import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/calc_history_data_source.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class CalcHistoryRepositoryImpl implements CalcHistoryRepository {
  final dataSource = CalcHistoryDataSource();

  @override
  Future<Result<CalcHistorySummary>> getCalcHistory() {
    return dataSource.getCalcHistory();
  }

  @override
  Future<Result<List<CalcHistoryDetailInfo>>> getCalcDetailList() {
    return dataSource.getCalcDetailList();
  }
}
