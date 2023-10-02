import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/controllers/report/report_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/modules/report/widgets/report_line_chart.dart';
import 'package:money_keeper/app/modules/report/widgets/report_pie_chart.dart';
import 'package:money_keeper/data/models/wallet.dart';

import '../../core/values/r.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<ReportController>()..initData();
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
        automaticallyImplyLeading: false,
        elevation: 5,
        centerTitle: true,
        title: Column(
          children: [
            Text(R.Balance.tr),
            Obx(() => Text(FormatHelper().moneyFormat(
                _controller.selectedWallet.value.balance?.toDouble()))),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                R.IncomeandExpense.tr,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(R.Summary.tr),
              Obx(
                () => Text(
                  FormatHelper()
                      .moneyFormat(_controller.summary.value.toDouble()),
                  style: TextStyle(
                    fontSize: 25,
                    color: _controller.summary.value < 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //line chart here
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 320,
                  width: 750,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Obx(() {
                      if (_controller.dy.isNotEmpty) {
                        return ReportLineChart();
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ),
                ),
              ),
              //income pie
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    R.Income.tr,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _controller.toIncomeDetailsScreen();
                    },
                    child: Text(
                      R.Detail.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Text(
                  FormatHelper()
                      .moneyFormat(_controller.incomeSummary.value.toDouble()),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              Obx(() {
                if (_controller.incomeSummary.value != 0) {
                  return Row(
                    children: [
                      Expanded(
                          child: ReportPieChart(
                              pieData: _controller.incomePie, type: "Income")),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              //expense pie
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    R.Expense.tr,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _controller.toExpenseDetailsScreen();
                    },
                    child: Text(
                      R.Detail.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Text(
                  FormatHelper()
                      .moneyFormat(_controller.expenseSummary.value.toDouble()),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              Obx(
                () {
                  if (_controller.expenseSummary.value != 0) {
                    return Row(
                      children: [
                        Expanded(
                            child: ReportPieChart(
                                pieData: _controller.expensePie,
                                type: "Expense")),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
