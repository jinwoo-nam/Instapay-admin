import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/store_info_data_source.dart';
import 'package:instapay_admin/data/data_source/local/token_local_data_source.dart';
import 'package:instapay_admin/domain/model/store/store.dart';
import 'package:instapay_admin/domain/repository/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final dataSource = StoreInfoDataSource();
  final tokenDataSource = TokenLocalDataSource();

  @override
  Future<Result<Store>> getStoreInfo(String token) async {
    return await dataSource.getStoreInfo(token);
  }
}
