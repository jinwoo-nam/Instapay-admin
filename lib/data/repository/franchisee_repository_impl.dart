import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/franchisee_info_data_source.dart';
import 'package:instapay_admin/data/data_source/local/token_local_data_source.dart';
import 'package:instapay_admin/domain/model/franchisee/store.dart';
import 'package:instapay_admin/domain/repository/franchisee_repository.dart';

class FranchiseeRepositoryImpl implements FranchiseeRepository {
  final dataSource = FranchiseeInfoDataSource();
  final tokenDataSource = TokenLocalDataSource();

  @override
  Future<Result<Store>> getStoreInfo(String token) async {
    return await dataSource.getStoreInfo(token);
  }
}
