import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';
import 'package:instapay_admin/domain/repository/trade_history_repository.dart';

class GetPaymentHistoryUseCase {
  TradeHistoryRepository repository;

  GetPaymentHistoryUseCase(this.repository);

  Future<Result<List<PaymentCompleteInfo>>> call() async {
    return await repository.getPaymentHistory();
  }
}
