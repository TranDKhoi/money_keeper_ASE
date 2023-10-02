import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/wallet.dart';
import '../../../../data/services/event_service.dart';
import '../../wallet/my_wallet_controller.dart';

class EventController extends GetxController {
  var listWallet = <Wallet>[].obs;
  var selectedWallet = Wallet().obs;
  var listEventFromAPI = <Event>[].obs;
  var listEvent = <Event>[].obs;

  int _currentIndex = 0;

  EventController() {
    listWallet.value = List.from(Get.find<MyWalletController>().listWallet);
    selectedWallet.value = listWallet[0];
  }

  Future<void> getAllEvent() async {
    EasyLoading.show();
    var res = await EventService.ins.getAllEvent(selectedWallet.value.id!);
    EasyLoading.dismiss();

    if (res.isOk) {
      listEventFromAPI.value = [];
      listEvent.value = [];
      for (int i = 0; i < res.data.length; i++) {
        listEventFromAPI.add(Event.fromJson(res.data[i]));
      }

      if (_currentIndex == 0) {
        listEvent.value = [];
        listEvent.value = List.from(listEventFromAPI
            .where((element) => element.isFinished == false)
            .toList());
      } else {
        listEvent.value = [];
        listEvent.value = List.from(listEventFromAPI
            .where((element) => element.isFinished == true)
            .toList());
      }
    } else {
      print(res.statusText);
      EasyLoading.showToast(res.errorMessage);
    }
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    getAllEvent();
  }

  Future<void> changeEventTabBar(int index) async {
    _currentIndex = index;
    await getAllEvent();
    if (index == 0) {
      listEvent.value = [];
      listEvent.value = List.from(listEventFromAPI
          .where((element) => element.isFinished == false)
          .toList());
    } else {
      listEvent.value = [];
      listEvent.value = List.from(listEventFromAPI
          .where((element) => element.isFinished == true)
          .toList());
    }
  }

  toggleEvent(int? id) async {
    EasyLoading.show();
    var res = await EventService.ins.toggleEvent(id!);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      getAllEvent();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  void deleteEvent(int? id) async {
    EasyLoading.show();
    var res = await EventService.ins.deleteEvent(id!);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      getAllEvent();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
}
