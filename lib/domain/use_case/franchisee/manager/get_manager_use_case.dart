import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/repository/manaer_repository.dart';

class GetManagerUseCase {
  ManagerRepository repository;

  GetManagerUseCase(this.repository);

  Future<Result<List<FranchiseeManagerInfo>>> call() async {
    return await repository.getManagerInfo();
  }
}
