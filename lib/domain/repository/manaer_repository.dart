import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';

abstract class ManagerRepository {
  Future<Result<List<FranchiseeManagerInfo>>> getManagerInfo();
  Future<void> addManagerInfo(FranchiseeManagerInfo manager);
  Future<void> deleteManagerInfo(int index);
}
