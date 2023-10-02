import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/bottombar_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/models/daily_report.dart';
import 'package:money_keeper/data/services/report_service.dart';

import '../../../data/models/pie_report.dart';
import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';
import '../wallet/my_wallet_controller.dart';

class ReportController extends GetxController {
  var selectedWallet = Wallet().obs;
  var listWallet = <Wallet>[].obs;
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();

  var dailyReport = RxList<DailyReport>();
  var incomePie = RxList<PieReport>();
  var expensePie = RxList<PieReport>();
  var summary = 0.obs;
  var incomeSummary = 0.obs;
  var expenseSummary = 0.obs;

  var dy = RxList<double>(); // cột dọc biểu đồ

  initData() async {
    var walletController = Get.find<MyWalletController>();

    Wallet globalWallet = Wallet(
        name: R.Totalwallet.tr, id: -1, balance: _calculateTotalBalance());

    listWallet.value = [
      globalWallet,
      ...walletController.listWallet,
      ...walletController.listGroupWallet
    ];

    if (listWallet.isEmpty) {
      EasyLoading.showToast(R.Walleterror.tr);
      Get.find<BottomBarController>().currentIndex.value = 0;
      return;
    }

    selectedWallet.value = listWallet[0];
    generateTimeLine();
    selectedTimeLine.value = listTimeline[listTimeline.length - 2];
    changeWallet(selectedWallet.value);
  }

  getReportData() async {
    _getLineData();
    _getIncomeData();
    _getExpenseData();
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    getReportData();
  }

  void changeTimeLine(int index) {
    selectedTimeLine.value = listTimeline[index];
    getReportData();
  }

  void toIncomeDetailsScreen() {
    Get.toNamed(incomeDetailRoute);
  }

  void toExpenseDetailsScreen() {
    Get.toNamed(expenseDetailRoute);
  }

  void generateTimeLine() {
    int yearStep = 1;
    while (yearStep <= 2) {
      if (yearStep == 1) {
        for (int i = 1; i <= 12; i++) {
          String time = "$i/${DateTime.now().year - 1}";
          listTimeline.add(time);
        }
      } else if (yearStep == 2) {
        for (int i = 1; i <= DateTime.now().month + 1; i++) {
          String time = "$i/${DateTime.now().year}";
          if (i == DateTime.now().month - 1) time = R.Lastmonth.tr;
          if (i == DateTime.now().month) time = R.Thismonth.tr;
          if (i == DateTime.now().month + 1) time = R.Nextmonth.tr;
          listTimeline.add(time);
        }
      }
      yearStep++;
    }
    for (int i = 0; i < listTimeline.length; i++) {
      if (listTimeline[i] == R.Thismonth.tr) {
        listTimeline[i - 1] = R.Lastmonth.tr;
      }
    }
  }

  _calculateTotalBalance() {
    int total = 0;
    for (int i = 0; i < listWallet.length; i++) {
      total += listWallet[i].balance!;
    }
    return total;
  }

  Future<void> _getLineData() async {
    EasyLoading.show();
    Response res;
    if (selectedWallet.value.id == -1) {
      res = await ReportService.ins
          .getDailyReportGlobal(timeRange: selectedTimeLine.value!);
    } else {
      res = await ReportService.ins.getDailyReportByWalletId(
          walletId: selectedWallet.value.id!,
          timeRange: selectedTimeLine.value!);
    }
    EasyLoading.dismiss();

    if (res.isOk) {
      dailyReport.value = [];
      dy.value = [];
      summary.value = res.data["netIncome"];
      for (int i = 0; i < res.data["dailyReports"].length; i++) {
        dailyReport.add(DailyReport.fromJson(res.data["dailyReports"][i]));
      }
      int maxIncome = dailyReport[0].income ?? 0;
      int maxExpense = dailyReport[0].expense ?? 0;

      for (int i = 0; i < dailyReport.length; i++) {
        if (maxIncome <= dailyReport[i].income!) {
          maxIncome = dailyReport[i].income!;
        }
        if (maxExpense <= dailyReport[i].expense!) {
          maxExpense = dailyReport[i].expense!;
        }
      }
      final int maxDy =
          (maxIncome > maxExpense ? maxIncome : maxExpense).ceil();

      dy.add(0);
      for (int i = 0; i <= 5; i++) {
        final value = maxDy / 5 * i;
        dy.add(value);
      }
      dy.add(dy[dy.length - 1] * 1.3);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  void _getIncomeData() {
    if (selectedWallet.value.id == -1) {
      ReportService.ins
          .getIncomeReportGlobal(timeRange: selectedTimeLine.value!)
          .then((res) {
        if (res.isOk) {
          incomePie.value = [];
          incomeSummary.value = res.data["totalAmount"];
          for (int i = 0; i < res.data["details"].length; i++) {
            incomePie.add(PieReport.fromJson(res.data["details"][i]));
          }
        } else {
          EasyLoading.showToast(res.errorMessage);
        }
      });
    } else {
      ReportService.ins
          .getIncomeReportByWalletId(
              walletId: selectedWallet.value.id!,
              timeRange: selectedTimeLine.value!)
          .then((res) {
        if (res.isOk) {
          incomePie.value = [];
          incomeSummary.value = res.data["totalAmount"];
          for (int i = 0; i < res.data["details"].length; i++) {
            incomePie.add(PieReport.fromJson(res.data["details"][i]));
          }
        } else {
          EasyLoading.showToast(res.errorMessage);
        }
      });
    }
  }

  void _getExpenseData() {
    if (selectedWallet.value.id == -1) {
      ReportService.ins
          .getExpenseReportGlobal(timeRange: selectedTimeLine.value!)
          .then((res) {
        if (res.isOk) {
          expensePie.value = [];
          expenseSummary.value = res.data["totalAmount"];
          for (int i = 0; i < res.data["details"].length; i++) {
            expensePie.add(PieReport.fromJson(res.data["details"][i]));
          }
        } else {
          EasyLoading.showToast(res.errorMessage);
        }
      });
    } else {
      ReportService.ins
          .getExpenseReportByWalletId(
              walletId: selectedWallet.value.id!,
              timeRange: selectedTimeLine.value!)
          .then((res) {
        if (res.isOk) {
          expensePie.value = [];
          expenseSummary.value = res.data["totalAmount"];
          for (int i = 0; i < res.data["details"].length; i++) {
            expensePie.add(PieReport.fromJson(res.data["details"][i]));
          }
        } else {
          EasyLoading.showToast(res.errorMessage);
        }
      });
    }
  }
}
