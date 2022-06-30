import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/tras/tras_history.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class GetTrasHistoryUseCase {
  TrasRepository repository;

  GetTrasHistoryUseCase(this.repository);

  Future<Result<TrasHistory>> call(String token, String tid, int limit,
      {String state = ''}) async {
    return repository.getTrasHistory(token, tid, limit, state: state);
  }
}
