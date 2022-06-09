import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class GetCalcHistoryUseCase {
  CalcHistoryRepository repository;

  GetCalcHistoryUseCase(this.repository);

  Future<Result<CalcHistorySummary>> call() async {
    return await repository.getCalcHistory();
  }
}
