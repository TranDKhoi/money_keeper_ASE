import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/models/wallet.dart';
import 'package:money_keeper/data/services/transaction_service.dart';

import '../../../data/models/transactions_by_time.dart';
import '../../core/values/r.dart';
import '../../modules/transaction/edit_transaction.dart';
import '../bottombar_controller.dart';
import '../wallet/my_wallet_controller.dart';

class TransactionController extends GetxController {
  var selectedWallet = Wallet().obs;
  var listWallet = <Wallet>[].obs;
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();

  var transactionsByTime = TransactionsByTime().obs;

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

  void toCreateTransactionScreen() {
    Get.toNamed(addTransactionRoute);
  }

  void toEditTransactionScreen(selected) {
    Get.to(() => EditTransactionScreen(selectedTrans: selected));
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    if (selectedWallet.value.id == -1) {
      getGlobalTransaction();
    } else {
      getTransactionByWalletId();
    }
  }

  void changeTimeLine(int index) {
    selectedTimeLine.value = listTimeline[index];
    if (selectedWallet.value.id == -1) {
      getGlobalTransaction();
    } else {
      getTransactionByWalletId();
    }
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

  getGlobalTransaction() async {
    EasyLoading.show();
    var res = await TransactionService.ins
        .getGlobalTransaction(selectedTimeLine.value!);
    EasyLoading.dismiss();

    if (res.isOk) {
      transactionsByTime.value = TransactionsByTime.fromJson(res.data);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  getTransactionByWalletId() async {
    EasyLoading.show();
    var res = await TransactionService.ins.getTransactionByWalletId(
        selectedWallet.value.id!, selectedTimeLine.value!);
    EasyLoading.dismiss();

    if (res.isOk) {
      transactionsByTime.value = TransactionsByTime.fromJson(res.data);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
}
