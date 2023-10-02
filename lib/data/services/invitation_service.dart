import 'package:get/get.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/strings.dart';

class InvitationService extends GetConnect {
  static final ins = InvitationService._();

  InvitationService._();

  final AccountController _ac = Get.find();

  Future<Response> getAllInvitation() async {
    return await get("$api_url/account/invitations", headers: <String, String>{
      "Authorization": _ac.currentUser.value!.token!,
    });
  }

  Future<Response> sendInvitationAnswer(int inviteID, bool isAccepted) async {
    return await get("$api_url/account/invitations/$inviteID/action", query: {
      "action": isAccepted ? "Accept" : "Decline"
    }, headers: <String, String>{
      "Authorization": _ac.currentUser.value!.token!,
    });
  }
}
