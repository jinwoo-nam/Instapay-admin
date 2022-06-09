import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';

class TradeHistoryDataSource {
  Future<Result<List<PaymentCompleteInfo>>> getPaymentHistory() async {
    return Result.success(paymentHistory);
  }
}

List<PaymentCompleteInfo> paymentHistory = [
  PaymentCompleteInfo(
    title: '본인인증',
    userName: '배재광',
    price: 10,
    paymentInstitution: '신한은행',
    orderNumber: 'v20dg0wd19z-04k08-20w48-f49iv',
    paymentDateTime: '2019-04-08 20:48:49',
  ),
];
