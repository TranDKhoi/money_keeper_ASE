import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/home_controller.dart';

import '../../../core/values/r.dart';

class HomeChartBar extends StatelessWidget {
  HomeChartBar(this.leftData, this.rightData, {Key? key}) : super(key: key);

  final HomeController _controller = Get.find();
  final int leftData;
  final int rightData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BarChart(
        BarChartData(
            gridData: FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(width: 0.3))),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4.0,
                    child: Obx(
                      () => Text(
                        _controller.selectedReport.value == 0
                            ? value.toInt() == 0
                                ? R.Lastweek.tr
                                : R.Thisweek.tr
                            : value.toInt() == 0
                                ? R.Lastmonth.tr
                                : R.Thismonth.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: leftData.toDouble(),
                    width: 50,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    color: Colors.redAccent,
                  )
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: rightData.toDouble(),
                    width: 50,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    color: Colors.redAccent,
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
