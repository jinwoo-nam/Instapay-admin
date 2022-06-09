import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class AddManagerUseCase {
  ManagerRepository repository;

  AddManagerUseCase(this.repository);

  Future<void> call(FranchiseeManagerInfo manager) async {
    await repository.addManagerInfo(manager);
  }
}
