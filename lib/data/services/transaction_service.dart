import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/R.dart';
import '../models/transaction.dart';

class TransactionService extends GetConnect {
  final AccountController _ac = Get.find();

  static final TransactionService ins = TransactionService._();

  TransactionService._() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response> createNewTransaction(Transaction newTrans) async {
    return await post("$api_url/wallets/${newTrans.walletId}/transactions",
        jsonEncode(newTrans),
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> updateTransaction(Transaction upTrans) async {
    return await put(
        "$api_url/wallets/${upTrans.walletId}/transactions/${upTrans.id}",
        jsonEncode(upTrans),
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getTransactionByWalletId(
    int walletId,
    String timeRange,
  ) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
          "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
          "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/wallets/$walletId/transactions",
        query: <String, String>{
          "StartDate": _getStartDate(timeRange),
          "EndDate": _getEndDate(timeRange),
        },
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }
  Future<Response> getGlobalTransaction(
      String timeRange,
      ) async {
    if (timeRange == R.Lastmonth.tr) {
      timeRange =
      "${DateTime.now().month - 1 <= 0 ? 12 : DateTime.now().month - 1}/${DateTime.now().year}";
    } else if (timeRange == R.Thismonth.tr) {
      timeRange = "${DateTime.now().month}/${DateTime.now().year}";
    } else if (timeRange == R.Nextmonth.tr) {
      timeRange =
      "${DateTime.now().month + 1 >= 13 ? 1 : DateTime.now().month + 1}/${DateTime.now().year}";
    }
    return await get("$api_url/global-wallets/transactions",
        query: <String, String>{
          "StartDate": _getStartDate(timeRange),
          "EndDate": _getEndDate(timeRange),
        },
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> deleteTransaction(Transaction delTrans) async {
    return await delete(
        "$api_url/wallets/${delTrans.walletId}/transactions/${delTrans.id}",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getTransactionByTransactionId(int walletId,int transactionId) async {
    return await get(
        "$api_url/wallets/$walletId/transactions/$transactionId",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getTransactionOfEvent(int walletId,int eventId) async {
    return await get(
        "$api_url/wallets/$walletId/transactions?EventId=$eventId",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> getRecentlyTrans() async{
    return await get(
        "$api_url/global-wallets/transactions/recently?Take=5",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }


  _getEndDate(String timeRange) {
    List<String> ele = timeRange.split("/");
    var dayOfThisTime =
        DateUtils.getDaysInMonth(int.parse(ele[1]), int.parse(ele[0]));
    return "${ele[1]}-${ele[0]}-$dayOfThisTime";
  }

  _getStartDate(String timeRange) {
    List<String> ele = timeRange.split("/");
    return "${ele[1]}-${ele[0]}-1";
  }

}
