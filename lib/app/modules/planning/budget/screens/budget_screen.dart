import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/modules/planning/budget/widget/budget_item.dart';
import 'package:money_keeper/app/modules/planning/budget/widget/summary_card.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../../../data/models/wallet.dart';
import '../../../../controllers/planning/budget/budget_controller.dart';
import '../../../../core/values/r.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final budgetController = Get.put(BudgetController());

  @override
  void initState() {
    _tabController = TabController(
        length: budgetController.listTimeline.length, vsync: this);
    _tabController.index = budgetController.listTimeline.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Budget.tr),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onTap: (value) => budgetController.selectMonth(value),
          tabs: budgetController.listTimeline
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(e),
                  ))
              .toList(),
        ),
        elevation: 5,
        actions: [
          Obx(
            () => DropdownButton<Wallet>(
              value: budgetController.selectedWallet.value,
              icon: const Icon(Ionicons.caret_down),
              onChanged: (Wallet? value) {
                budgetController.changeWallet(value!);
              },
              items: budgetController.listWallet.map((Wallet value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SummaryCard(isVisible: true),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => (budgetController.budgets.isNotEmpty)
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) => InkWell(
                          onTap: () async {
                            await budgetController.initBudgetInfoScreenData(
                                budgetId:
                                    budgetController.budgets[i].id as int);
                            Get.toNamed(budgetInfoScreen);
                          },
                          child:
                              BudgetItem(budget: budgetController.budgets[i]),
                        ),
                        separatorBuilder: (context, i) => const Divider(),
                        itemCount: budgetController.budgets.length,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              R.noneBudget.tr,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              R.pressPlusBudget.tr,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: context.height * 0.2),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () async {
          await Get.toNamed(addBudgetScreenRoute,arguments: false);
          budgetController.resetData();
        },
      ),
    );
  }
}
