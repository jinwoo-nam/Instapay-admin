import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_info.dart';

abstract class FranchiseeRepository {
  Future<Result<FranchiseeInfo>> getFranchiseeInfo();
}
