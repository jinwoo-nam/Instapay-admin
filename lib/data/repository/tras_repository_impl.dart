import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/data/data_source/remote/tras_data_source.dart';
import 'package:instapay_admin/domain/model/tras/tras_history.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class TrasHistoryRepositoryImpl implements TrasRepository {
  final dataSource = TrasDataSource();

  @override
  Future<Result<TrasHistory>> getTrasHistory(
      String token, String tid, int limit,
      {String state = ''}) {
    return dataSource.getTrasHistory(token, tid, limit, state: state);
  }
}
