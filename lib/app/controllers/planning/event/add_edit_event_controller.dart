import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../../data/models/event.dart';
import '../../../../data/models/wallet.dart';
import '../../../../data/services/event_service.dart';
import '../../../core/values/r.dart';
import 'event_controller.dart';

class AddEditEventController extends GetxController {
  var selectedIcon = Rxn<int>();
  var endDate = Rxn<DateTime>();
  var selectedWallet = Rxn<Wallet>();
  var selectedEvent = Rxn<Event>();
  final eventName = TextEditingController();

  void setSelectedEditEvent(Event se) {
    selectedEvent.value = se;
  }

  createNewEvent() async {
    if (!isValidData()) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
      return;
    }

    Event nE = Event(
      icon: selectedIcon.value.toString(),
      name: eventName.text.trim(),
      endDate: endDate.value,
      walletId: selectedWallet.value?.id,
    );

    EasyLoading.show();
    var res = await EventService.ins.createNewEvent(nE);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      Get.find<EventController>().getAllEvent();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  editEvent() async {
    if (!isValidData()) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
      return;
    }

    Event nE = Event(
      id: selectedEvent.value!.id,
      icon: selectedIcon.value.toString(),
      name: eventName.text.trim(),
      endDate: endDate.value,
      walletId: selectedWallet.value?.id,
    );

    EasyLoading.show();
    var res = await EventService.ins.editEvent(nE);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      Get.back();
      Get.find<EventController>().getAllEvent();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  void applyData() {
    selectedIcon.value = int.parse(selectedEvent.value!.icon!);
    endDate.value = selectedEvent.value?.endDate;
    selectedWallet.value = selectedEvent.value?.wallet;
    eventName.text = selectedEvent.value?.name ?? "";
  }

  bool isValidData() {
    return selectedIcon.value != null &&
        endDate.value != null &&
        selectedWallet.value != null &&
        eventName.text.trim().isNotEmpty;
  }
}
