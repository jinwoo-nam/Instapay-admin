import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/repository/login_repository.dart';

class LoginUseCase {
  LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Result<Map>> call(String aid, String pack) async {
    return await repository.login(aid, pack);
  }
}
