import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/store.dart';

abstract class StoreRepository {
  Future<Result<Store>> getStoreInfo(String token);
}
