import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/modules/account/account_screen.dart';
import 'package:money_keeper/app/modules/transaction/transaction_screen.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../modules/home/home_screen.dart';
import '../modules/planning/planning_screen.dart';
import '../modules/report/report_screen.dart';

class BottomBarController extends GetxController {
  List<Widget> listPage = [
    const HomeScreen(),
    const TransactionScreen(),
    const ReportScreen(),
    const PlanningScreen(),
    const AccountScreen(),
  ];

  var currentIndex = 0.obs;

  void changePage(int val) {
    currentIndex.value = val;
  }

  void toCreateTransactionScreen() {
    Get.toNamed(addTransactionRoute);
  }
}
