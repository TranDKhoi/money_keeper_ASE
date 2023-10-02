import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';

class StorageService {
  static final ins = StorageService._();

  StorageService._();

  final _store = FirebaseStorage.instance;

  Future<String?> uploadImageToStorage(File file) async {
    final ac = Get.find<AccountController>();

    try {
      Reference ref = _store
          .ref()
          .child("transaction/${ac.currentUser.value?.token}/image.png");
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
    return null;
  }
}
