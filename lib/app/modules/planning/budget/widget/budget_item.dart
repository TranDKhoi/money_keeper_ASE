import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/planning/budget/budget_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/models/budget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/values/r.dart';

class BudgetItem extends StatelessWidget {
  const BudgetItem({super.key, required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    int limitAmount = budget.limitAmount as int;
    int spentAmount = budget.spentAmount as int;
    int remainingAmount = limitAmount - spentAmount;
    bool isPast =
        (budgetController.selectedDateTime.year < DateTime.now().year ||
            budgetController.selectedDateTime.month < DateTime.now().month);

    double percentage =
        (spentAmount / limitAmount) > 1 ? 1 : spentAmount / limitAmount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //title and icon
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                "assets/icons/${budget.category?.icon}.png",
                height: 40,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              budget.category?.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  FormatHelper().moneyFormat(limitAmount.toDouble()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    "${R.remaining.tr}: ${FormatHelper().moneyFormat(remainingAmount.toDouble())}"),
              ],
            ),
          ],
        ),

        const SizedBox(height: 5),
        //the bar here
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 30),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                left: 20,
                child: LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  width: 300,
                  lineHeight: 10.0,
                  percent: percentage.toDouble(),
                  barRadius: const Radius.circular(50),
                  backgroundColor: Colors.grey,
                  progressColor:
                      percentage > (budgetController.cursorPosition / 300)
                          ? Colors.red
                          : Colors.green, //or red if 100%,
                ),
              ),
              Visibility(
                visible: !isPast,
                child: Positioned(
                  left: budgetController.cursorPosition, // from 0 to 300
                  child: Column(
                    children: [
                      //this is the red cursor
                      Container(
                        color: Colors.green,
                        width: 1,
                        height: 10,
                      ),
                      BubbleBox(
                        shape: BubbleShapeBorder(
                          position: const BubblePosition.center(0),
                          direction: BubbleDirection.top,
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: Text(R.now.tr),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
