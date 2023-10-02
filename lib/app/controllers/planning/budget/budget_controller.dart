import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/models/budget.dart';
import 'package:money_keeper/data/models/budget_detail_statistic.dart';
import 'package:money_keeper/data/models/budget_detail_summary.dart';
import 'package:money_keeper/data/models/budget_summary.dart';
import 'package:money_keeper/data/models/category.dart';
import 'package:money_keeper/data/models/create_budget.dart';
import 'package:money_keeper/data/models/transactions_by_time.dart';
import 'package:money_keeper/data/services/budget_service.dart';

import '../../../../data/models/wallet.dart';
import '../../../core/values/r.dart';
import '../../wallet/my_wallet_controller.dart';

class BudgetController extends GetxController {
  RxList<String> listTimeline = <String>[].obs;
  RxList<Wallet> listWallet = <Wallet>[].obs;
  Rx<Wallet> selectedWallet = Wallet().obs;
  RxList<Budget> budgets = <Budget>[].obs;
  DateTime selectedDateTime = DateTime.now();
  Rxn<BudgetSummary> budgetSummary = Rxn<BudgetSummary>();

  // add budget screen prop
  Rxn<Category> category = Rxn<Category>();
  final TextEditingController limitAmount = TextEditingController();

  // budget detail screen
  Budget budget = Budget();
  Rxn<BudgetDetailSummary> budgetDetailSummary = Rxn<BudgetDetailSummary>();
  late List<BudgetDetailStatistic> statistics;
  List<double> dy = []; // cột dọc biểu đồ

  // budget transaction screen
  late TransactionsByTime transaction;

  BudgetController() {
    listWallet.value = List.from(Get.find<MyWalletController>().listWallet);
    if (listWallet.isEmpty) {
      EasyLoading.showToast(R.Walleterror);
      return;
    }
    selectedWallet.value = listWallet[0];
    generateTimeLine();
    calculatePositionByMonth();
    EasyLoading.show();
    Future.wait([
      getBudgetsInMonth(),
      initBudgetSummaryData(),
    ]);
    EasyLoading.dismiss();
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    resetData();
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
        for (int i = 1; i <= DateTime.now().month; i++) {
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

  //this logic is for the indicator and cursor position
  double _cursorPosition = 1; // only from 0 to 290
  double get cursorPosition => _cursorPosition <= 0 ? 5 : _cursorPosition * 295;

  void calculatePositionByMonth() {
    int today = DateTime.now().day;
    int dayInMonth =
        DTU.getDaysInMonth(DateTime.now().year, DateTime.now().month);
    if (today == 1) today = 0;
    double diffPercentage = today / dayInMonth;
    _cursorPosition *= diffPercentage;
  }

  Future<bool> resetData() async {
    category.value = null;
    dy.clear();
    EasyLoading.show();
    await Future.wait([
      getBudgetsInMonth(),
      initBudgetSummaryData(),
    ]);
    EasyLoading.dismiss();
    return true;
  }

  void selectMonth(int value) {
    int month = value + 1;
    int year = DateTime.now().year - 1;
    if (value > 11) {
      month = value - 11;
      year++;
    }
    selectedDateTime = DateTime(year, month);
    resetData();
  }

  Future<void> initBudgetSummaryData() async {
    budgetSummary.value = await getBudgetSummaryInMonth();
  }

  // add budget screen method
  Future<void> createBudget() async {
    if (limitAmount.text.trim().isEmpty || category.value == null) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation);
      return;
    }

    try {
      CreateBudget createBudget = CreateBudget(
        limitAmount:
            int.parse(limitAmount.text.trim().replaceAll(RegExp(r"\D"), "")),
        month: selectedDateTime.month,
        year: selectedDateTime.year,
        categoryId: category.value?.id,
        walletId: selectedWallet.value.id,
      );

      EasyLoading.show();
      var res = await BudgetService.ins.createBudget(
        walletId: selectedWallet.value.id as int,
        createBudget: createBudget,
      );
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.back();
        EasyLoading.showToast(R.Createbudgetsuccessfully.tr);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    } catch (e) {
      log("create budget error: $e");
      EasyLoading.dismiss();
    }
  }

  // edit budget method
  Future<void> editBudget() async {
    if (limitAmount.text.trim().isEmpty || category.value == null) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation);
      return;
    }

    try {
      CreateBudget createBudget = CreateBudget(
        limitAmount:
            int.parse(limitAmount.text.trim().replaceAll(RegExp(r"\D"), "")),
        month: selectedDateTime.month,
        year: selectedDateTime.year,
        categoryId: category.value?.id,
        walletId: selectedWallet.value.id,
      );

      EasyLoading.show();
      var res = await BudgetService.ins.editBudget(
        budgetId: budget.id as int,
        walletId: selectedWallet.value.id as int,
        editBudget: createBudget,
      );
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.back();
        EasyLoading.showToast(R.editBudgetsuccessfully.tr);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    } catch (e) {
      log("edit budget error: $e");
      EasyLoading.dismiss();
    }
  }

  // budget info screen method

  Future<void> initBudgetInfoScreenData({required int budgetId}) async {
    EasyLoading.show();
    await getBudgetById(budgetId: budgetId);
    category.value = budget.category;
    await Future.wait([
      getBudgetDetailSummary(),
      getBudgetStatistic(),
    ]);
    int? max = statistics[0].expenseAmount as int;
    for (int i = DateTime.now().day;
        i < DTU.getDaysInMonth(selectedDateTime.year, selectedDateTime.month);
        i++) {
      if (statistics[i].expenseAmount != null) {
        statistics[i].expenseAmount = statistics[i - 1].expenseAmount;
        int temp = statistics[i].expenseAmount as int;
        statistics[i].expenseAmount =
            temp + budgetDetailSummary.value!.expectedExpense!.round();
        if (statistics[i].expenseAmount! > max!) {
          max = statistics[i].expenseAmount;
        }
      }
    }
    dy.add(0);
    for (int i = 1; i <= 5; i++) {
      dy.add(dy[i - 1] + max!.ceil() / 5);
    }
    EasyLoading.dismiss();
  }

  Future<void> getBudgetDetailSummary() async {
    try {
      var res = await BudgetService.ins.getBudgetDetailSummary(
        budgetId: budget.id as int,
        walletId: selectedWallet.value.id as int,
        month: selectedDateTime.month,
        year: selectedDateTime.year,
      );
      if (res.isOk) {
        budgetDetailSummary.value =
            BudgetDetailSummary.fromJson(res.body["data"]);
      }
      log(res.body["message"]);
    } catch (e) {
      log("get budget detail summary error: $e");
    }
  }

  Future<void> getBudgetStatistic() async {
    try {
      var res = await BudgetService.ins.getBudgetStatistic(
        budgetId: budget.id as int,
        walletId: selectedWallet.value.id as int,
        month: selectedDateTime.month,
        year: selectedDateTime.year,
      );
      if (res.isOk) {
        statistics = List.from(res.body["data"]
            .map((json) => BudgetDetailStatistic.fromJson(json)));
      }
      log(res.body["message"]);
    } catch (e) {
      log("get budget statistic error: $e");
    }
  }

  // budget transaction screen
  Future<void> initBudgetTransactionScreenData() async {
    try {
      EasyLoading.show();
      var res = await BudgetService.ins.getBudgetTransaction(
        budgetId: budget.id as int,
        walletId: selectedWallet.value.id as int,
        month: selectedDateTime.month,
        year: selectedDateTime.year,
      );
      EasyLoading.dismiss();
      if (res.isOk) {
        transaction = TransactionsByTime.fromJson(res.body["data"]);
      }
      log(res.body["message"]);
    } catch (e) {
      log("get budget transaction error: $e");
      EasyLoading.dismiss();
    }
  }

  // call api
  Future<void> getBudgetsInMonth() async {
    try {
      budgets.clear();
      var res = await BudgetService.ins.getBudgetsInMonth(
        walletId: selectedWallet.value.id as int,
        month: selectedDateTime.month,
        year: selectedDateTime.year,
      );
      if (res.isOk) {
        budgets.value =
            List.from(res.data.map((budget) => Budget.fromJson(budget)));
      }
      log(res.body["message"]);
    } catch (e) {
      log("get budget in month error: $e");
    }
  }

  Future<BudgetSummary?> getBudgetSummaryInMonth() async {
    try {
      EasyLoading.show();
      var res = await BudgetService.ins.getBudgetSummaryInMonth(
        walletId: selectedWallet.value.id as int,
        month: selectedDateTime.month,
        year: selectedDateTime.year,
      );
      EasyLoading.dismiss();
      if (res.isOk) {
        BudgetSummary result = BudgetSummary.fromJson(res.data);
        log(res.body["message"]);
        return result;
      }
      log(res.body["message"]);
    } catch (e) {
      log("get summary budget in month error: $e");
      EasyLoading.dismiss();
    }
    return null;
  }

  Future<void> getBudgetById({required int budgetId}) async {
    await getBudgetsInMonth();
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].id == budgetId) {
        budget = budgets[i];
        break;
      }
    }
  }

  deleteBudget() async {
    EasyLoading.show();
    var res = await BudgetService.ins
        .deleteBudget(budgetId: budget.id!, walletId: selectedWallet.value.id!);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
}
