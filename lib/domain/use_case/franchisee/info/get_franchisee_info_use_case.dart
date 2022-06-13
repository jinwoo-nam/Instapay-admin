import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_info.dart';
import 'package:instapay_admin/domain/repository/franchisee_repository.dart';

class GetFranchiseeInfoUseCase {
  FranchiseeRepository repository;

  GetFranchiseeInfoUseCase(this.repository);

  Future<Result<FranchiseeInfo>> call() async {
    return await repository.getFranchiseeInfo();
  }
}
