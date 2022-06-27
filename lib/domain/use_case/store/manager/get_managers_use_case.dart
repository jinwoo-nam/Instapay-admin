import 'package:instapay_admin/domain/model/store/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class GetManagersUseCase {
  ManagerRepository repository;

  GetManagersUseCase(this.repository);

  List<Contact> call() {
    return repository.getManagers();
  }
}
