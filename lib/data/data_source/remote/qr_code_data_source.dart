import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';

class QrCodeDataSource {
    Future<Result<List<QrCodeInfo>>> getQrInfoList() async {
      return Result.success(qrInfoList);
    }
}

List<QrCodeInfo> qrInfoList = [
  QrCodeInfo(
    title: 'AAA',
    price: 100,
    expireDate: '2022-06-02 16:43:38',
    createDate: '2022-06-02 16:43:38',
    state: '중단',
  ),
  QrCodeInfo(
    title: 'BBB',
    price: 100,
    expireDate: '2022-06-02 16:43:38',
    createDate: '2022-06-02 16:43:38',
    state: '중단',
  ),
];
