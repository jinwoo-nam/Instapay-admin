import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class SetManagerUseCase {
  ManagerRepository repository;

  SetManagerUseCase(this.repository);

  Future<void> call(List<Contact> managers) async {
    repository.setManagers(managers);
  }
}
