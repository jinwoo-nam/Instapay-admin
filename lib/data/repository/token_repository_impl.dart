import 'package:instapay_admin/data/data_source/local/token_local_data_source.dart';
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
  Future<void> deleteAccessToken() async {
    await tokenLocalDataSource.deleteAccessToken();
  }

  @override
  Future<String> loadLoginHash() async {
    return await tokenLocalDataSource.loadLoginHash();
  }

  @override
  Future<void> saveLoginHash(String hash) async {
    await tokenLocalDataSource.saveLoginHash(hash);
  }

  @override
  Future<void> deleteLoginHash() async {
    await tokenLocalDataSource.deleteLoginHash();
  }

  @override
  Future<bool> loadIsAutoLogin() async {
    return await tokenLocalDataSource.loadIsAutoLogin();
  }

  @override
  Future<void> saveIsAutoLogin(bool isAutoLogin) async {
    await tokenLocalDataSource.saveIsAutoLogin(isAutoLogin);
  }

  @override
  Future<void> deleteIsAutoLogin() async {
    await tokenLocalDataSource.deleteIsAutoLogin();
  }

  @override
  Future<String> loadUserLoginId() async {
    return await tokenLocalDataSource.loadUserLoginId();
  }

  @override
  Future<void> saveUserLoginId(String loginId) async {
    await tokenLocalDataSource.saveUserLoginId(loginId);
  }

  @override
  Future<void> deleteUserLoginId() async {
    await tokenLocalDataSource.deleteUserLoginId();
  }
}
