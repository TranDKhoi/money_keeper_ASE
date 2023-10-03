import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../../app/features/account/controller/account_controller.dart';
import '../models/event.dart';

class EventService extends GetConnect {
  static final ins = EventService._();
  final AccountController _ac = Get.find();

  EventService._();

  Future<Response> getAllEvent(int i) async {
    return await get(
      "$baseUrl/events?walletId=$i",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> createNewEvent(Event event) async {
    return await post(
      "$baseUrl/events",
      jsonEncode(event),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> editEvent(Event nE) async {
    return await put(
      "$baseUrl/events/${nE.id}",
      jsonEncode(nE),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> deleteEvent(int id) async {
    return await delete(
      "$baseUrl/events/$id",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> toggleEvent(int i) async {
    return await get(
      "$baseUrl/events/$i/toggle-finished",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
