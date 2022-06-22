import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenLocalDataSource {
  final secureStorage = const FlutterSecureStorage();

  Future<String> loadAccessToken() async {
    return await secureStorage.read(key: 'access_token') ?? '';
  }

  Future<void> saveAccessToken(String token) async {
    await secureStorage.write(key: 'access_token', value: token);
  }

  Future<void> deleteAccessToken() async {
    await secureStorage.delete(key: 'access_token');
  }

  Future<String> loadLoginHash() async {
    return await secureStorage.read(key: 'login_hash') ?? '';
  }

  Future<void> saveLoginHash(String hash) async {
    await secureStorage.write(key: 'login_hash', value: hash);
  }

  Future<void> deleteLoginHash() async {
    await secureStorage.delete(key: 'login_hash');
  }

  Future<void> saveIsAutoLogin(bool isAutoLogin) async {
    String val = isAutoLogin ? 'true' : 'false';
    await secureStorage.write(key: 'isAutoLogin', value: val);
  }

  Future<bool> loadIsAutoLogin() async {
    String temp = await secureStorage.read(key: 'isAutoLogin') ?? '';
    if (temp == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteIsAutoLogin() async {
    await secureStorage.delete(key: 'isAutoLogin');
  }

  Future<String> loadUserLoginId() async {
    return await secureStorage.read(key: 'user_login_id') ?? '';
  }

  Future<void> saveUserLoginId(String loginId) async {
    await secureStorage.write(key: 'user_login_id', value: loginId);
  }

  Future<void> deleteUserLoginId() async {
    await secureStorage.delete(key: 'user_login_id');
  }

}
