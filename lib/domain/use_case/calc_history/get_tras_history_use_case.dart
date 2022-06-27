import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_history.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class GetTrasHistoryUseCase {
  CalcHistoryRepository repository;

  GetTrasHistoryUseCase(this.repository);

  Future<Result<TrasHistory>> call(String token, String tid, int limit,
      {String state = ''}) async {
    return repository.getTrasHistory(token, tid, limit, state: state);
  }
}
