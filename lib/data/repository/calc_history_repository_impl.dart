import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/calc_history_data_source.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_history.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class CalcHistoryRepositoryImpl implements CalcHistoryRepository {
  final dataSource = CalcHistoryDataSource();

  @override
  Future<Result<TrasHistory>> getTrasHistory(
      String token, String tid, int limit) {
    return dataSource.getTrasHistory(token, tid, limit);
  }
}
