import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/modules/report/widgets/report_pie_chart.dart';

import '../../common/widget/in_ex_item.dart';
import '../../controllers/report/report_controller.dart';
import '../../core/values/r.dart';

class IncomeDetail extends StatelessWidget {
  IncomeDetail({Key? key}) : super(key: key);

  final _controller = Get.find<ReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Incomedetail.tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                R.Totalincome.tr,
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                FormatHelper().moneyFormat(_controller.incomeSummary.value.toDouble()),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ReportPieChart(
                    pieData: _controller.incomePie,
                    type: "Income",
                  ))
                ],
              ),
              const Divider(thickness: 1),
              ..._controller.incomePie.map((e) => InExItem(e)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
