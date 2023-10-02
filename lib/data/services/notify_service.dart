import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../../app/controllers/account/account_controller.dart';

class NotifyService extends GetConnect {
  static final NotifyService ins = NotifyService._();

  NotifyService._();

  final AccountController _ac = Get.find();

  Future<Response> getAllNotify() async {
    return await get("$api_url/notifications", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  Future<Response> seenById({required int id}) async {
    return await get("$api_url/notifications/$id/seen",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }

  Future<Response> seenAllNotify() async {
    return await get("$api_url/notifications/seen-all",
        headers: <String, String>{
          'Authorization': _ac.currentUser.value!.token!,
        });
  }
}
