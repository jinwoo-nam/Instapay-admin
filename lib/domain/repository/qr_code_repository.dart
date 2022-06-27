import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/goods.dart';

abstract class QrCodeRepository {
  Future<Result<List<Goods>>> getQrInfoList(String token);
}
