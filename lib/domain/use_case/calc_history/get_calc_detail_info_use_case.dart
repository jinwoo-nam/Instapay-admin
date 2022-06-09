import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/repository/calc_history_repository.dart';

class GetCalcDetailInfoUseCase {
  CalcHistoryRepository repository;

  GetCalcDetailInfoUseCase(this.repository);

  Future<Result<List<CalcHistoryDetailInfo>>> call() async {
    return await repository.getCalcDetailList();
  }
}
