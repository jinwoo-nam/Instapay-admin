import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class DeleteManagerUseCase {
  ManagerRepository repository;

  DeleteManagerUseCase(this.repository);

  Future<void> call(int index) async {
    await repository.deleteManagerInfo(index);
  }
}
