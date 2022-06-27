import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class DeleteManagerUseCase {
  ManagerRepository repository;

  DeleteManagerUseCase(this.repository);

  Future<Result<String>> call(int index, String token) async {
    return await repository.deleteManagerInfo(index, token);
  }
}
