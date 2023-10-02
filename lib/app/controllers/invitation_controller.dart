import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/models/invitation.dart';

import '../../data/services/invitation_service.dart';

class InvitationController extends GetxController {
  var listInvite = <Invitation>[].obs;

  getAllInvitation() async {
    EasyLoading.show();
    var res = await InvitationService.ins.getAllInvitation();
    EasyLoading.dismiss();

    if (res.isOk) {
      listInvite.value = [];
      var tempList = <Invitation>[];
      for (int i = 0; i < res.data.length; i++) {
        tempList.add(Invitation.fromJson(res.data[i]));
      }
      listInvite.value = List.from(tempList.reversed);
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }

  sendInvitationAnswer(int id, bool isAccepted) async {
    EasyLoading.show();
    var res = await InvitationService.ins.sendInvitationAnswer(id, isAccepted);
    EasyLoading.dismiss();

    if (res.isOk) {
      getAllInvitation();
    } else {
      EasyLoading.showToast(res.errorMessage);
    }
  }
}
