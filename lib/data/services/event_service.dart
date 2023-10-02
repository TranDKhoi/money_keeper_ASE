import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../../app/controllers/account/account_controller.dart';
import '../models/event.dart';

class EventService extends GetConnect {
  static final ins = EventService._();
  final AccountController _ac = Get.find();

  EventService._();

  Future<Response> getAllEvent(int i) async {
    return await get(
      "$api_url/events?walletId=$i",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> createNewEvent(Event event) async {
    return await post(
      "$api_url/events",
      jsonEncode(event),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> editEvent(Event nE) async {
    return await put(
      "$api_url/events/${nE.id}",
      jsonEncode(nE),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> deleteEvent(int id) async {
    return await delete(
      "$api_url/events/$id",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> toggleEvent(int i) async {
    return await get(
      "$api_url/events/$i/toggle-finished",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
