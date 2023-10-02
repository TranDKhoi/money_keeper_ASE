import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';
import 'package:money_keeper/data/models/create_budget.dart';

import '../../app/controllers/account/account_controller.dart';

class BudgetService extends GetConnect {
  final AccountController _ac = Get.find();

  BudgetService._() {
    timeout = const Duration(seconds: 10);
  }

  static final ins = BudgetService._();

  Future<Response> getBudgetsInMonth(
      {required int walletId, required int month, required int year}) async {
    return await get(
      "$api_url/wallets/$walletId/budgets?month=$month&year=$year",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getBudgetSummaryInMonth(
      {required int walletId, required int month, required int year}) async {
    return await get(
      "$api_url/wallets/$walletId/budgets/summary?month=$month&year=$year",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> createBudget(
      {required int walletId, required CreateBudget createBudget}) async {
    return await post(
      "$api_url/wallets/$walletId/budgets",
      createBudget.toJson(),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getBudgetDetailSummary(
      {required int budgetId,
      required int walletId,
      required int month,
      required int year}) async {
    return await get(
      "$api_url/wallets/$walletId/budgets/$budgetId/summary?month=$month&year=$year",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getBudgetStatistic(
      {required int budgetId,
      required int walletId,
      required int month,
      required int year}) async {
    return await get(
      "$api_url/wallets/$walletId/budgets/$budgetId/statistic?month=$month&year=$year",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getBudgetTransaction(
      {required int budgetId,
      required int walletId,
      required int month,
      required int year}) async {
    return await get(
      "$api_url/wallets/$walletId/budgets/$budgetId/transactions?month=$month&year=$year",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> editBudget(
      {required int budgetId,
      required int walletId,
      required CreateBudget editBudget}) async {
    return await put(
      "$api_url/wallets/$walletId/budgets/$budgetId",
      editBudget.toJson(),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> deleteBudget({
    required int budgetId,
    required int walletId,
  }) async {
    return await delete(
      "$api_url/wallets/$walletId/budgets/$budgetId",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
