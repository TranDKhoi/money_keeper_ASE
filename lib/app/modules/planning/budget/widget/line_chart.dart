import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:money_keeper/app/controllers/planning/budget/budget_controller.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartState();
}

class _LineChartState extends State<LineChartWidget> {
  final budgetController = Get.find<BudgetController>();
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        mainData(),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (value == 1 ||
        value ==
            DTU
                .getDaysInMonth(DateTime.now().year, DateTime.now().month)
                .toDouble()) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toInt().toString()),
      );
    }
    return const SizedBox.shrink();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value > 5) return const SizedBox.shrink();
    return Text(budgetController.dy[value.round()].toStringAsFixed(1),
        textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: null,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 3,
          sideTitles: SideTitles(
            showTitles: true,
            interval: (budgetController.dy[5] / 5 == 0)
                ? 1
                : (budgetController.dy[5] / 5),
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: DTU
          .getDaysInMonth(DateTime.now().year, DateTime.now().month)
          .toDouble(),
      minY: 0,
      maxY: budgetController.dy[5],
      // this is total of this budget
      lineBarsData: [
        //this is where we put the data in start from day 1
        LineChartBarData(
          spots: budgetController.statistics
              .map((e) => FlSpot(e.date?.day.toDouble() as double,
                  e.expenseAmount!.toDouble()))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
