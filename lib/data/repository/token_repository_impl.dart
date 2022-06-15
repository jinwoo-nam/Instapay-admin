import 'package:instapay_admin/data/data_source/token_local_data_source.dart';
import 'package:instapay_admin/domain/repository/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource tokenLocalDataSource = TokenLocalDataSource();

  TokenRepositoryImpl();

  @override
  Future<String> loadAccessToken() async {
    return await tokenLocalDataSource.loadAccessToken();
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await tokenLocalDataSource.saveAccessToken(token);
  }
}
