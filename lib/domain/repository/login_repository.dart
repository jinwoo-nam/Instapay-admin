import 'package:instapay_admin/core/result.dart';

abstract class LoginRepository {
  Future<Result<Map>> login(String aid, String pack);
}
