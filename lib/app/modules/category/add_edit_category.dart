import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/modules/category/widgets/category_icon_modal.dart';
import 'package:money_keeper/data/models/category.dart';
import 'package:money_keeper/data/services/category_service.dart';

import '../../controllers/category/category_controller.dart';
import '../../core/values/r.dart';

class AddEditCategoryScreen extends StatefulWidget {
  const AddEditCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  List<DropdownMenuItem<int>> listGroup = [
    DropdownMenuItem(value: 0, child: Text(R.RequiredExpense.tr)),
    DropdownMenuItem(value: 1, child: Text(R.NecessaryExpense.tr)),
    DropdownMenuItem(value: 2, child: Text(R.Entertainment.tr)),
    DropdownMenuItem(value: 3, child: Text(R.InvestingOrDebt.tr)),
  ];

  final nameController = TextEditingController();
  final CategoryController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    applyData();
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          //category name
          Obx(
            () => _controller.selectedEditCategory.value == null
                ? TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: R.Categoryname.tr))
                : TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: R.Categoryname.tr),
                    onChanged: (val) => nameController.text = val.trim(),
                  ),
          ),
          const SizedBox(height: 20),
          //icon and category type
          Row(
            children: [
              //icon
              GestureDetector(
                onTap: () async {
                  var res = await showModalBottomSheet<int>(
                      context: context,
                      builder: (BuildContext context) =>
                          const IconModalBottomSheet());

                  if (res != null) {
                    _controller.selectedCategoryPic.value = res;
                  }
                },
                child: Obx(
                  () {
                    if (_controller.selectedCategoryPic.value != null) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                            "assets/icons/${_controller.selectedCategoryPic.value}.png"),
                      );
                    }
                    if (_controller.selectedEditCategory.value != null) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                            "assets/icons/${_controller.selectedEditCategory.value!.icon}.png"),
                      );
                    }
                    return const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              //type
              Expanded(
                child: Obx(
                  () => DropdownButton<String>(
                    value: _controller.selectedType.value,
                    hint: Text(R.Type.tr),
                    isExpanded: true,
                    icon: const Icon(Ionicons.caret_down),
                    onChanged: (String? value) {
                      _controller.changeType(value!);
                    },
                    items: _controller.listType.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //group of this category
          Obx(
            () => _controller.selectedType.value == R.Expense.tr
                ? Row(
                    children: [
                      //icon
                      const Icon(Ionicons.list, size: 40),
                      const SizedBox(width: 20),
                      //dropdown
                      Obx(
                        () => Expanded(
                          child: DropdownButton<int>(
                            value: _controller.selectedGroup.value,
                            isExpanded: true,
                            icon: const Icon(Ionicons.caret_down),
                            onChanged: (int? value) {
                              _controller.selectedGroup.value = value!;
                            },
                            items: listGroup,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                if (_controller.selectedEditCategory.value != null) {
                  _editCate();
                } else {
                  createNewCate();
                }
              },
              child: Text(R.Save.tr))
        ],
      ),
    );
  }

  void applyData() {
    if (_controller.selectedEditCategory.value != null) {
      _controller.selectedType.value =
          _controller.selectedEditCategory.value!.type == "Income"
              ? R.Income.tr
              : R.Expense.tr;

      switch (_controller.selectedEditCategory.value!.group) {
        case "RequiredExpense":
          _controller.selectedGroup.value = 0;
          break;
        case "NecessaryExpense":
          _controller.selectedGroup.value = 1;
          break;
        case "Entertainment":
          _controller.selectedGroup.value = 2;
          break;
        case "InvestingOrDebt":
          _controller.selectedGroup.value = 3;
          break;
        default:
          _controller.selectedGroup.value = 0;
          break;
      }

      nameController.text = _controller.selectedEditCategory.value!.name!;
    }
  }

  Future<void> _editCate() async {
    //đang chọn gói danh mục tiêu chuẩn chứ ko phải của ví khác
    if (_controller.selectedWallet.value.id == -1) {
    } else {
      //check dieu kien
      if (!isValidData()) return;

      //nếu là khoản thu thì group hay type đều là Income nhé
      final editCate = Category();

      editCate.id = _controller.selectedEditCategory.value!.id;
      editCate.name = nameController.text.trim();
      editCate.icon = _controller.selectedCategoryPic.value.toString();
      editCate.walletId = _controller.selectedWallet.value.id;

      if (_controller.selectedType.value == R.Income.tr) {
        editCate.group = "Income";
        editCate.type = "Income";
      } else if (_controller.selectedType.value == R.Expense.tr) {
        editCate.type = "Expense";
        switch (_controller.selectedGroup.value) {
          case 0:
            editCate.group = "RequiredExpense";
            break;
          case 1:
            editCate.group = "NecessaryExpense";
            break;
          case 2:
            editCate.group = "Entertainment";
            break;
          case 3:
            editCate.group = "InvestingOrDebt";
            break;
        }
      }

      EasyLoading.show();
      var res = await CategoryService.ins.updateCategoryByWalletId(editCate);
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.back();
        _controller.getCateByWalletId(editCate.walletId!);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    }
  }

  Future<void> createNewCate() async {
    //đang chọn gói danh mục tiêu chuẩn chứ ko phải của ví khác
    if (_controller.selectedWallet.value.id == -1) {
      print("here");
    } else {
      //check dieu kien
      if (!isValidData()) return;

      //nếu là khoản thu thì group hay type đều là Income nhé
      final newCate = Category();

      newCate.name = nameController.text.trim();
      newCate.icon = _controller.selectedCategoryPic.value.toString();
      newCate.walletId = _controller.selectedWallet.value.id;

      if (_controller.selectedType.value == R.Income.tr) {
        newCate.group = "Income";
        newCate.type = "Income";
      } else if (_controller.selectedType.value == R.Expense.tr) {
        newCate.type = "Expense";
        switch (_controller.selectedGroup.value) {
          case 0:
            newCate.group = "RequiredExpense";
            break;
          case 1:
            newCate.group = "NecessaryExpense";
            break;
          case 2:
            newCate.group = "Entertainment";
            break;
          case 3:
            newCate.group = "InvestingOrDebt";
            break;
        }
      }

      EasyLoading.show();
      var res = await CategoryService.ins.createCategoryByWalletId(newCate);
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.back();
        _controller.getCateByWalletId(newCate.walletId!);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    }
  }

  bool isValidData() {
    return nameController.text.trim().isNotEmpty &&
        _controller.selectedType.value != null &&
        _controller.selectedType.value!.isNotEmpty &&
        _controller.selectedCategoryPic.value != null;
  }
}
