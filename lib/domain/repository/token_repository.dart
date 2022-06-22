abstract class TokenRepository {
  Future<String> loadAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> deleteAccessToken();

  Future<String> loadLoginHash();
  Future<void> saveLoginHash(String hash);
  Future<void> deleteLoginHash();

  Future<bool> loadIsAutoLogin();
  Future<void> saveIsAutoLogin(bool isAutoLogin);
  Future<void> deleteIsAutoLogin();

  Future<String> loadUserLoginId();
  Future<void> saveUserLoginId(String loginId);
  Future<void> deleteUserLoginId();
}
