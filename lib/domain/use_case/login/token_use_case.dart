import 'package:instapay_admin/domain/repository/token_repository.dart';

class TokenUseCase {
  final TokenRepository repository;

  TokenUseCase(this.repository);

  Future<void> saveToken(String token) async {
    await repository.saveAccessToken(token);
  }

  Future<String> loadAccessToken() async {
    return await repository.loadAccessToken();
  }

  Future<void> deleteAccessToken() async {
    await repository.deleteAccessToken();
  }

  Future<void> saveLoginHash(String hash) async {
    await repository.saveLoginHash(hash);
  }

  Future<String> loadLoginHash() async {
    return await repository.loadLoginHash();
  }

  Future<void> deleteLoginHash() async {
    await repository.deleteLoginHash();
  }

  Future<void> saveIsAutoLogin(bool isAutoLogin) async {
    await repository.saveIsAutoLogin(isAutoLogin);
  }

  Future<bool> loadIsAutoLogin() async {
    return await repository.loadIsAutoLogin();
  }

  Future<void> deleteIsAutoLogin() async {
    await repository.deleteIsAutoLogin();
  }

  Future<void> saveUserLoginId(String loginUserId) async {
    await repository.saveUserLoginId(loginUserId);
  }

  Future<String> loadUserLoginId() async {
    return await repository.loadUserLoginId();
  }

  Future<void> deleteUserLoginId() async {
    await repository.deleteUserLoginId();
  }
}
