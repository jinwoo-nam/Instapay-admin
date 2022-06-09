import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';

abstract class QrCodeRepository {
  Future<Result<List<QrCodeInfo>>> getQrInfoList();
}