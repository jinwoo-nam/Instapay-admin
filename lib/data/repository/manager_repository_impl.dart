import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/franchisee_manager_data_source.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final dataSource = FranchiseeManagerDataSource();

  @override
  Future<Result<List<FranchiseeManagerInfo>>> getManagerInfo() async {
    return await dataSource.getManagerInfo();
  }

  @override
  Future<void> addManagerInfo(FranchiseeManagerInfo manager) async {
    await dataSource.addManagerInfo(manager);
  }

  @override
  Future<void> deleteManagerInfo(int index) async {
    await dataSource.deleteManagerInfo(index);
  }
}
