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

  @override
  Future<String> loadLoginHash() async{
    return await tokenLocalDataSource.loadLoginHash();
  }

  @override
  Future<void> saveLoginHash(String hash) async {
    await tokenLocalDataSource.saveLoginHash(hash);
  }
}
