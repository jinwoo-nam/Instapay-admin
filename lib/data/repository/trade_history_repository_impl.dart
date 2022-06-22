import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/trade_history_data_source.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';
import 'package:instapay_admin/domain/repository/trade_history_repository.dart';

class TradeHistoryRepositoryImpl implements TradeHistoryRepository {
  final dataSource = TradeHistoryDataSource();

  @override
  Future<Result<List<PaymentCompleteInfo>>> getPaymentHistory() {
    return dataSource.getPaymentHistory();
  }
}
