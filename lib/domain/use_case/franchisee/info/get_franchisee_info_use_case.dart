import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/store.dart';
import 'package:instapay_admin/domain/repository/franchisee_repository.dart';

class GetStoreInfoUseCase {
  FranchiseeRepository repository;

  GetStoreInfoUseCase(this.repository);

  Future<Result<Store>> getStoreInfo(String token) async {
    return await repository.getStoreInfo(token);
  }
}
