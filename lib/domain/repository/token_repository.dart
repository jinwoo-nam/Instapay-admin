abstract class TokenRepository {
  Future<String> loadAccessToken();

  Future<void> saveAccessToken(String token);

  Future<String> loadLoginHash();

  Future<void> saveLoginHash(String hash);
}
