import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/R.dart';
import '../../app/core/values/strings.dart';

class ReportService extends GetConnect {
  static final ins = ReportService._();

  ReportService._();

  final AccountController _ac = Get.find();

  Future<Response> getDailyReportByWalletId(
      {required int walletId, required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/wallets/$walletId/statistic/group",
        query: <String, String>{
          "StartDate": _getStartDate(timeRange),
          "EndDate": _getEndDate(timeRange),
        },
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getDailyReportGlobal({required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/global-wallets/group", query: <String, String>{
      "StartDate": _getStartDate(timeRange),
      "EndDate": _getEndDate(timeRange),
    }, headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  Future<Response> getIncomeReportByWalletId(
      {required int walletId, required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/wallets/$walletId/statistic/income",
        query: <String, String>{
          "StartDate": _getStartDate(timeRange),
          "EndDate": _getEndDate(timeRange),
        },
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getIncomeReportGlobal({required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/global-wallets/income", query: <String, String>{
      "StartDate": _getStartDate(timeRange),
      "EndDate": _getEndDate(timeRange),
    }, headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  Future<Response> getExpenseReportByWalletId(
      {required int walletId, required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/wallets/$walletId/statistic/expense",
        query: <String, String>{
          "StartDate": _getStartDate(timeRange),
          "EndDate": _getEndDate(timeRange),
        },
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getExpenseReportGlobal({required String timeRange}) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/global-wallets/expense", query: <String, String>{
      "StartDate": _getStartDate(timeRange),
      "EndDate": _getEndDate(timeRange),
    }, headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  _getEndDate(String timeRange) {
    List<String> ele = timeRange.split("/");
    var dayOfThisTime =
        DTU.getDaysInMonth(int.parse(ele[1]), int.parse(ele[0]));
    return "${ele[1]}-${ele[0]}-$dayOfThisTime";
  }

  _getStartDate(String timeRange) {
    List<String> ele = timeRange.split("/");
    return "${ele[1]}-${ele[0]}-1";
  }
}
