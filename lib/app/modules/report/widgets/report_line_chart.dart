import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/report/report_controller.dart';

class ReportLineChart extends StatelessWidget {
  ReportLineChart({Key? key}) : super(key: key);
  final Color dark = Colors.redAccent;
  final Color light = const Color(0xff73e8c9);
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final List<Color> gradientColorsRed = [
    const Color(0xffff1515),
    const Color(0xfff33535),
  ];

  final _controller = Get.find<ReportController>();

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
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString()),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value > 5) return const SizedBox.shrink();
    return Text(_controller.dy[value.round()].toStringAsFixed(1),
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
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 3,
          sideTitles: SideTitles(
            showTitles: true,
            interval: (_controller.dy[_controller.dy.length - 1] / 5 == 0)
                ? 1
                : (_controller.dy[_controller.dy.length - 1] / 5),
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
      maxX: _controller.dailyReport.length.toDouble(),
      minY: 0,
      maxY: _controller.dy[_controller.dy.length - 1],
      // this is total of this budget
      lineBarsData: [
        //this is where we put the data in start from day 1
        LineChartBarData(
          spots: _controller.dailyReport
              .map((e) => FlSpot(e.date!.day.toDouble(), e.income!.toDouble()))
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
        LineChartBarData(
          spots: _controller.dailyReport
              .map((e) => FlSpot(
                  e.date?.day.toDouble() as double, e.expense!.toDouble()))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColorsRed,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColorsRed
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
