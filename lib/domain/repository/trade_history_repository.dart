import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';

abstract class TradeHistoryRepository {
  Future<Result<List<PaymentCompleteInfo>>> getPaymentHistory();
}
