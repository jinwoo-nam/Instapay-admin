import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';

abstract class CalcHistoryRepository {
  Future<Result<CalcHistorySummary>> getCalcHistory();

  Future<Result<List<CalcHistoryDetailInfo>>> getCalcDetailList();
}
