import 'package:get/get.dart';

import '../../app/core/values/strings.dart';
import '../../app/features/account/controller/account_controller.dart';

class InvitationService extends GetConnect {
  static final ins = InvitationService._();

  InvitationService._();

  final AccountController _ac = Get.find();

  Future<Response> getAllInvitation() async {
    return await get("$baseUrl/account/invitations", headers: <String, String>{
      "Authorization": _ac.currentUser.value!.token!,
    });
  }

  Future<Response> sendInvitationAnswer(int inviteID, bool isAccepted) async {
    return await get("$baseUrl/account/invitations/$inviteID/action", query: {
      "action": isAccepted ? "Accept" : "Decline"
    }, headers: <String, String>{
      "Authorization": _ac.currentUser.value!.token!,
    });
  }
}
