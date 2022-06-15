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
}