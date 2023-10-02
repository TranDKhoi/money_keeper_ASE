import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/services/services.dart';
import '../../../data/models/user.dart';
import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';

class MyWalletController extends GetxController {
  var listWallet = <Wallet>[].obs;
  var listGroupWallet = <Wallet>[].obs;
  var listMember = <User>[];
  var categoryGroupList = <Wallet>[].obs;
  var selectedCategoryGroup = Wallet().obs;
  var selectedCategoryPic = Rxn<int>();

  void getAllCategoryGroup() {
    selectedCategoryPic.value = null;
    categoryGroupList.value = [
      Wallet(name: R.Standard.tr, id: -1),
      ...listWallet
    ];
    selectedCategoryGroup.value = categoryGroupList[0];
  }

  Future<void> getAllWallet() async {
    listWallet.value = [];
    listGroupWallet.value = [];
    EasyLoading.show();
    var res = await WalletService.ins.getAllWallet();
    EasyLoading.dismiss();
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        if (res.data[i]["type"] == "Personal") {
          listWallet.add(Wallet.fromJson(res.data[i]));
        } else {
          listGroupWallet.add(Wallet.fromJson(res.data[i]));
        }
      }
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  Future<bool> checkAlreadyUser({required String email}) async {
    EasyLoading.show();
    var res = await UserService.ins.checkAlreadyUser(email: email);
    EasyLoading.dismiss();
    if (res.isOk) {
      if(res.body['data'] != null) {
        listMember.add(User.fromJson(res.body['data']));
        return true;
      }
    }
    return false;
  }

  void toEditWallet(Wallet selectedWallet) {
    Get.toNamed(editWalletRoute, arguments: selectedWallet);
  }

  void toAddWallet() {
    Get.toNamed(addWalletRoute);
  }

  void createNewWallet(Wallet wallet) async {
    EasyLoading.show();
    var res = await WalletService.ins.createNewWallet(wallet: wallet);
    if (res.isOk) {
      Get.back();
      getAllWallet();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
    EasyLoading.dismiss();
  }

  String calculateTotalBalance() {
    double total = 0;
    for (int i = 0; i < listWallet.length; i++) {
      total += listWallet[i].balance!;
    }
    for (int i = 0; i < listGroupWallet.length; i++) {
      total += listGroupWallet[i].balance!;
    }
    return FormatHelper().moneyFormat(total.toDouble());
  }

  void deleteWallet(int? id) async {
    EasyLoading.show();
    var res = await WalletService.ins.deleteWallet(id!);
    EasyLoading.dismiss();
  if (res.isOk) {
      Get.back();
      getAllWallet();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
  void updateWallet(Wallet wallet) async {
    EasyLoading.show();
    var res = await WalletService.ins.updateWallet(wallet: wallet);
    EasyLoading.dismiss();
    if (res.isOk) {
      Get.back();
      getAllWallet();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  
  }
}
