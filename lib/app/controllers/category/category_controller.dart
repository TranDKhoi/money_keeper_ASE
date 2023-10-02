import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../data/models/category.dart';
import '../../../data/models/wallet.dart';
import '../../../data/services/category_service.dart';
import '../../core/values/r.dart';
import '../../modules/category/widgets/expanded_list_tile.dart';
import '../wallet/my_wallet_controller.dart';

class CategoryController extends GetxController {
  //manage screen prop
  var listCate = <Category>[].obs;
  var listIncome = <Category>[].obs;
  var listExpense = <Category>[].obs;
  var listExpenseTile = <BasicTile>[].obs;
  var selectedWallet = Wallet().obs;
  var listWallet = <Wallet>[].obs;
  var currentTabIndex = 0.obs;

  CategoryController() {
    var walletController = Get.find<MyWalletController>();
    listWallet.value = [...walletController.listWallet];
    var standardCate = Wallet(name: R.Standard.tr, id: -1);
    listWallet.value = [standardCate, ...walletController.listWallet];
    selectedWallet.value = listWallet[0];
  }

  void getStandardCate() async {
    listCate.value = [];
    EasyLoading.show();
    var res = await CategoryService.ins.getAllCategory();
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        listCate.add(Category.fromJson(res.data[i]));
      }
    }
    EasyLoading.dismiss();
    changeListCategory(currentTabIndex.value);
  }

  void getCateByWalletId(int id) async {
    listCate.value = [];
    EasyLoading.show();
    var res = await CategoryService.ins.getCategoryByWalletId(id);
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        listCate.add(Category.fromJson(res.data[i]));
      }
    }
    EasyLoading.dismiss();
    changeListCategory(currentTabIndex.value);
  }

  void changeListCategory(int index) {
    currentTabIndex.value = index;
    switch (index) {
      case 0:
        listIncome.value =
            List.from(listCate.where((p0) => p0.type == "Income"));
        break;
      case 1:
        {
          listExpense.value =
              List.from(listCate.where((p0) => p0.type == "Expense"));

          listExpenseTile.value = <BasicTile>[
            BasicTile(
              tileName: R.RequiredExpense.tr,
              tiles: listExpense
                  .where((p0) => p0.group == "RequiredExpense")
                  .toList(),
            ),
            BasicTile(
              tileName: R.NecessaryExpense.tr,
              tiles: listExpense
                  .where((p0) => p0.group == "NecessaryExpense")
                  .toList(),
            ),
            BasicTile(
              tileName: R.Entertainment.tr,
              tiles: listExpense
                  .where((p0) => p0.group == "Entertainment")
                  .toList(),
            ),
            BasicTile(
              tileName: R.InvestingOrDebt.tr,
              tiles: listExpense
                  .where((p0) => p0.group == "InvestingOrDebt")
                  .toList(),
            ),
          ];
          break;
        }
    }
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    if (value.id! == -1) {
      getStandardCate();
      return;
    }
    getCateByWalletId(value.id!);
  }

  //add or edit prop
  var selectedCategoryPic = Rxn<int>();
  var selectedEditCategory = Rxn<Category>();
  var selectedType = Rxn<String>();
  var selectedGroup = 0.obs;
  var listType = [R.Income.tr, R.Expense.tr];

  void changeType(String val) {
    selectedType.value = val;
  }

  Future<void> deleteCategory(Category delCate) async {
    if (selectedWallet.value.id == -1) {
      EasyLoading.showToast(R.Cannotdeletestandard.tr);
      return;
    }
    EasyLoading.show();
    var res = await CategoryService.ins.deleteCategoryByWalletId(delCate);
    EasyLoading.dismiss();

    if (res.isOk) {
      getCateByWalletId(delCate.walletId!);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
}
