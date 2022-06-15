import 'package:instapay_admin/data/data_source/franchisee_manager_data_source.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final dataSource = FranchiseeManagerDataSource();

  @override
  Future<void> addManagerInfo(Contact manager) async {
    await dataSource.addManagerInfo(manager);
  }

  @override
  Future<void> deleteManagerInfo(int index) async {
    await dataSource.deleteManagerInfo(index);
  }
}
