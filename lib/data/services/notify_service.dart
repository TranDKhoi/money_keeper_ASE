import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../../app/features/account/controller/account_controller.dart';

class NotifyService extends GetConnect {
  static final NotifyService ins = NotifyService._();

  NotifyService._();

  final AccountController _ac = Get.find();

  Future<Response> getAllNotify() async {
    return await get("$baseUrl/notifications", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  Future<Response> seenById({required int id}) async {
    return await get("$baseUrl/notifications/$id/seen", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }

  Future<Response> seenAllNotify() async {
    return await get("$baseUrl/notifications/seen-all", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }
}
