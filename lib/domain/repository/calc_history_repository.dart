import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_history.dart';

abstract class CalcHistoryRepository {
  Future<Result<TrasHistory>> getTrasHistory(
      String token, String tid, int limit);
}
