import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/modules/category/widgets/expanded_list_tile.dart';

import '../../../data/models/category.dart';
import '../../../data/models/wallet.dart';
import '../../controllers/category/category_controller.dart';
import '../../core/values/r.dart';
import 'add_edit_category.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen(
      {Key? key,
      this.canBack = true,
      this.canChangeWallet = true,
      this.onlyExpense = false,
      this.selectedWallet})
      : super(key: key);

  final bool canBack;
  final bool canChangeWallet;

  // nếu bằng true thì chỉ hiện expense
  final bool onlyExpense;

  //nó sẽ bằng null khi đi từ màn hình quản lý danh mục, khác null khi đi từ màn hình tạo mới giao dịch (bắt buộc phải chọn ví rồi mới dc chọn category ví đó)
  final Wallet? selectedWallet;

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(CategoryController());

  late TabController _tabController;

  @override
  void initState() {
    if (widget.selectedWallet != null) {
      _controller.selectedWallet.value = widget.selectedWallet!;
      _controller.getCateByWalletId(widget.selectedWallet!.id!);
    } else {
      _controller.getStandardCate();
    }
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeListCategory(_tabController.index);
      }
    });

    _controller.changeListCategory(0);
    if (widget.onlyExpense) {
      _tabController.index = 1;
      _controller.currentTabIndex.value = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.ManageCategory.tr),
        actions: [
          Visibility(
            visible: widget.canChangeWallet,
            child: Obx(
              () => DropdownButton<Wallet>(
                value: _controller.selectedWallet.value,
                icon: const Icon(Ionicons.caret_down),
                onChanged: (Wallet? value) {
                  _controller.changeWallet(value!);
                },
                items: _controller.listWallet.map((Wallet value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value.name!),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            (widget.onlyExpense)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(R.Income.tr),
                  ),
            (widget.onlyExpense)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(R.Expense.tr),
                  ),
          ],
        ),
      ),
      //////////////////
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if (_controller.currentTabIndex.value == 0) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) =>
                    _buildSlideItem(_controller.listIncome[i]),
                itemCount: _controller.listIncome.length,
                separatorBuilder: (context, i) => const Divider(),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) =>
                    _buildExpandedTile(_controller.listExpenseTile[i]),
                itemCount: _controller.listExpenseTile.length,
                separatorBuilder: (context, i) => const Divider(),
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) => const AddEditCategoryScreen());
          _controller.selectedCategoryPic.value = null;
        },
        foregroundColor: Colors.white,
        child: const Icon(Ionicons.add),
      ),
    );
  }

  Widget _buildSlideItem(Category cate) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              _controller.selectedEditCategory.value = cate;
              _controller.selectedCategoryPic.value =
                  int.parse(_controller.selectedEditCategory.value!.icon!);
              await showDialog(
                  context: context,
                  builder: (context) => const AddEditCategoryScreen());
              _controller.selectedEditCategory.value = null;
            },
            backgroundColor: Colors.green,
            icon: Ionicons.pencil,
          ),
          SlidableAction(
            onPressed: (context) {
              _controller.deleteCategory(cate);
            },
            backgroundColor: Colors.red,
            icon: Ionicons.trash_outline,
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if (widget.canBack) Get.back(result: cate);
        },
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset("assets/icons/${cate.icon}.png"),
        ),
        title: Text(cate.name ?? ""),
      ),
    );
  }

  _buildExpandedTile(BasicTile listCate) {
    return ExpansionTile(
      title: Text(listCate.tileName),
      children: listCate.tiles
          .map((e) => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildSlideItem(e),
              ))
          .toList(),
    );
  }
}
