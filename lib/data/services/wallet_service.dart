import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/values/strings.dart';

import '../models/wallet.dart';

class WalletService extends GetConnect {
  final AccountController _ac = Get.find();

  WalletService._(){
    timeout =  const Duration(seconds: 10);
  }

  static final ins = WalletService._();

  Future<Response> getAllWallet() async {
    return await get(
      "$api_url/wallets",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getWalletMemberById({required int id}) async {
    return await get(
      "$api_url/wallets/$id/members",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> createNewWallet({required Wallet wallet}) async {
    return await post(
      "$api_url/wallets",
      jsonEncode(wallet),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> deleteWallet(int walletId) async {
    return await delete(
      "$api_url/wallets/$walletId",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
  
  Future<Response> updateWallet({required Wallet wallet}) async {
    return await put(
      "$api_url/wallets/${wallet.id}",
      wallet.toJson(),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
