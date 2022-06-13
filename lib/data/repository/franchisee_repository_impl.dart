import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/franchisee_info_data_source.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_info.dart';
import 'package:instapay_admin/domain/repository/franchisee_repository.dart';

class FranchiseeRepositoryImpl implements FranchiseeRepository {
  final dataSource = FranchiseeInfoDataSource();

  @override
  Future<Result<FranchiseeInfo>> getFranchiseeInfo() async {
    return await dataSource.getFranchiseeInfo();
  }
}
