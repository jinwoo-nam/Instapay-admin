import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class AddManagerUseCase {
  ManagerRepository repository;

  AddManagerUseCase(this.repository);

  Future<Result<String>> call(Contact manager, String token) async {
    return await repository.addManagerInfo(manager, token);
  }
}
