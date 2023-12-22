import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/features/account/account_screen.dart';
import 'package:money_keeper/app/features/transaction/transaction_screen.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../home/home_screen.dart';
import '../../planning/planning_screen.dart';
import '../../report/report_screen.dart';

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
    if (val == 2) return;
    currentIndex.value = val;
  }

  void toCreateTransactionScreen() {
    Get.toNamed(addTransactionRoute);
  }
}
