import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/login_data_source.dart';
import 'package:instapay_admin/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final dataSource = LoginDataSource();

  @override
  Future<Result<Map>> login(String aid, String pack) async {
    return await dataSource.login(aid, pack);
  }
}
