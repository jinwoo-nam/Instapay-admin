import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/store.dart';
import 'package:instapay_admin/domain/repository/store_repository.dart';

class GetStoreInfoUseCase {
  StoreRepository repository;

  GetStoreInfoUseCase(this.repository);

  Future<Result<Store>> getStoreInfo(String token) async {
    return await repository.getStoreInfo(token);
  }
}
