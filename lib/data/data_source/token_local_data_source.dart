import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenLocalDataSource {
  final secureStorage = const FlutterSecureStorage();

  Future<String> loadAccessToken() async {
    return await secureStorage.read(key: 'access_token') ?? '';
  }

  Future<void> saveAccessToken(String token) async {
    await secureStorage.write(key: 'access_token', value: token);
  }
}