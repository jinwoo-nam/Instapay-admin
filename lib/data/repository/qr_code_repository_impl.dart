import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/qr_code_data_source.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';
import 'package:instapay_admin/domain/repository/qr_code_repository.dart';

class QrCodeRepositoryImpl implements QrCodeRepository {
  final dataSource = QrCodeDataSource();

  @override
  Future<Result<List<QrCodeInfo>>> getQrInfoList() async {
    return await dataSource.getQrInfoList();
  }
}
