import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/goods.dart';
import 'package:instapay_admin/domain/repository/qr_code_repository.dart';

class GetQrInfoListUseCase {
  QrCodeRepository repository;

  GetQrInfoListUseCase(this.repository);

  Future<Result<List<Goods>>> call(String token) async {
    return await repository.getQrInfoList(token);
  }
}
