abstract class TokenRepository {
  Future<String> loadAccessToken();

  Future<void> saveAccessToken(String token);
}
