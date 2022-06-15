import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class AddManagerUseCase {
  ManagerRepository repository;

  AddManagerUseCase(this.repository);

  Future<void> call(Contact manager) async {
    await repository.addManagerInfo(manager);
  }
}
