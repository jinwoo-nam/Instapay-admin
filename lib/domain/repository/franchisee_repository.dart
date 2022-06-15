import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/store.dart';

abstract class FranchiseeRepository {
  Future<Result<Store>> getStoreInfo(String token);
}
