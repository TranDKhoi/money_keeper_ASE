import 'package:get_storage/get_storage.dart';

class GetStorageService {
  GetStorageService._();

  static final ins = GetStorageService._();

  final _box = GetStorage();

  void setUserToken(String token) async {
    await _box.write("userToken", "Bearer $token");
  }

  String? getUserToken() {
    return _box.read("userToken");
  }

  void clearUserToken() {
    _box.remove("userToken");
  }

  void setAppTheme(bool isDark) async {
    await _box.write("isDark", isDark);
  }

  bool getAppTheme() {
    return _box.read("isDark") ?? false;
  }

  void clearAppTheme() {
    _box.remove("isDark");
  }

  void setAppLanguage(bool isVN) async {
    await _box.write("isVN", isVN);
  }

  bool getAppLanguage() {
    return _box.read("isVN") ?? false;
  }

  void clearAppLanguage() {
    _box.remove("isVN");
  }
}
