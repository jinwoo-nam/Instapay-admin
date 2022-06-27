import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/store_manager_data_source.dart';
import 'package:instapay_admin/domain/model/store/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final dataSource = StoreManagerDataSource();

  @override
  List<Contact> getManagers() {
    return dataSource.getManagers();
  }

  @override
  void setManagers(List<Contact> managers) {
    dataSource.setManagers(managers);
  }

  @override
  Future<Result<String>> addManagerInfo(Contact manager, String token) async {
    return await dataSource.addManager(manager, token);
  }

  @override
  Future<Result<String>> deleteManagerInfo(int index, String token) async {
    return await dataSource.deleteManager(index, token);
  }
}
