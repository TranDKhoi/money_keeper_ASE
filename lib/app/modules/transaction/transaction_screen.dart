import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/transaction/transaction_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/wallet.dart';
import '../../common/widget/card_transction_item.dart';
import '../../core/values/r.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<TransactionController>()..initData();
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: _controller.listTimeline.length, vsync: this);
    _tabController.index = _controller.listTimeline.length - 2;
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _controller.changeTimeLine(_tabController.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text(R.Balance.tr),
            Obx(() => Text(FormatHelper()
                .moneyFormat(_controller.selectedWallet.value.balance?.toDouble()))),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.screenSize.height * 0.1),
          child: Column(
            children: [
              Obx(() => DropdownButton<Wallet>(
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
                  )),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                tabs: _controller.listTimeline
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(e),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(() {
          if (_controller.selectedTimeLine.value != null) {
            return Column(
              children: [
                Visibility(
                  visible: false,
                  child: Text(
                    _controller.selectedTimeLine.value!,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(R.Income.tr),
                            const Spacer(),
                            Obx(
                              () => Text(
                                FormatHelper().moneyFormat(_controller
                                    .transactionsByTime.value.totalIncome?.toDouble()),
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(R.Expense.tr),
                            const Spacer(),
                            Obx(
                              () => Text(
                                FormatHelper().moneyFormat(_controller
                                    .transactionsByTime.value.totalExpense?.toDouble()),
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              FormatHelper().moneyFormat((_controller
                                          .transactionsByTime
                                          .value
                                          .totalIncome ??
                                      0) -
                                  (_controller.transactionsByTime.value
                                          .totalExpense ??
                                      0).toDouble()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text(R.Viewreportofthisperiod.tr),
                        // ),
                      ],
                    ),
                  ),
                ),
                ...?_controller.transactionsByTime.value.details
                    ?.map((e) => CardTransactionItem(
                          transactionsByDay: e,
                        ))
                    .toList()
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
