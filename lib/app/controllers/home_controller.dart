import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../data/models/transaction.dart';
import '../../data/services/global_wallet_service.dart';

class HomeController extends GetxController {
  var selectedReport = 1.obs;
  var transactions = <Transaction>[].obs;
  var barChartData = <int>[0, 0].obs;

  void changeSelectedReport() {
    selectedReport.value = selectedReport.value == 0 ? 1 : 0;
    getSummaryData();
  }

  void toAllWalletScreen() {
    Get.toNamed(myWalletRoute);
  }

  getSummaryData() async {
    if (selectedReport.value == 0) {
      await Future.wait([
        GlobalWalletService.ins
            .getExpenseReportByWeek(DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 1))
                .day)
            .then((value) {
          if (value.isOk) {
            barChartData[1] = value.data["totalAmount"];
          } else {
            EasyLoading.showToast(value.errorMessage);
          }
        }),
        GlobalWalletService.ins
            .getExpenseReportByWeek(DateTime.now()
                    .subtract(Duration(days: DateTime.now().weekday - 1))
                    .day -
                7)
            .then((value) {
          if (value.isOk) {
            barChartData[0] = value.data["totalAmount"];
          } else {
            EasyLoading.showToast(value.errorMessage);
          }
        }),
      ]);
      barChartData.refresh();
    } else {
      await Future.wait([
        GlobalWalletService.ins
            .getExpenseReportByMonth(DateTime.now())
            .then((value) {
          if (value.isOk) {
            barChartData[1] = value.data["totalAmount"];
          } else {
            EasyLoading.showToast(value.errorMessage);
          }
        }),
        GlobalWalletService.ins
            .getExpenseReportByMonth(
                DateTime(DateTime.now().year, DateTime.now().month - 1))
            .then((value) {
          if (value.isOk) {
            barChartData[0] = value.data["totalAmount"];
          } else {
            EasyLoading.showToast(value.errorMessage);
          }
        }),
      ]);
      barChartData.refresh();
    }
  }

  getRecentTransaction() async {
    var res = await GlobalWalletService.ins.getRecentlyTrans();
    if (res.isOk) {
      transactions.value = [];
      for (int i = 0; i < res.data.length; i++) {
        transactions.add(Transaction.fromJson(res.data[i]));
      }
    }
  }
}
