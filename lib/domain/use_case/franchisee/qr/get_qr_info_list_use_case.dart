import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';
import 'package:instapay_admin/domain/repository/qr_code_repository.dart';

class GetQrInfoListUseCase {
  QrCodeRepository repository;

  GetQrInfoListUseCase(this.repository);

  Future<Result<List<QrCodeInfo>>> call() async {
    return await repository.getQrInfoList();
  }
}
