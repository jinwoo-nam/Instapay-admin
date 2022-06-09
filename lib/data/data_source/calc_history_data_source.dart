import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary_info.dart';

class CalcHistoryDataSource {
  Future<Result<CalcHistorySummary>> getCalcHistory() async {
    return Result.success(calcHistory);
  }

  Future<Result<List<CalcHistoryDetailInfo>>> getCalcDetailList() async {
    return Result.success(calcDetailList);
  }
}

CalcHistorySummary calcHistory = CalcHistorySummary(
  complete: CalcHistorySummaryInfo(
    state: '승인',
    count: 7,
    price: 601000,
    vat: 6613,
    result: 594397,
  ),
  cancel: CalcHistorySummaryInfo(
    state: '취소',
    count: 0,
    price: 0,
    vat: 0,
    result: 0,
  ),
  hold: CalcHistorySummaryInfo(
    state: '보류',
    count: 0,
    price: 0,
    vat: 0,
    result: 0,
  ),
  holdCancel: CalcHistorySummaryInfo(
    state: '보류 해제',
    count: 0,
    price: 0,
    vat: 0,
    result: 0,
  ),
  finalPrice: CalcHistorySummaryInfo(
    state: '최종 금액',
    count: 0,
    price: 0,
    vat: 0,
    result: 594397,
  ),
);

List<CalcHistoryDetailInfo> calcDetailList = [
  CalcHistoryDetailInfo(
      state: 'complete',
      acceptDate: '2019-04-08 20:48:49',
      paymentPrice: 10,
      paymentMethod: 'kfcbank',
      commission: 1,
      vat: 1,
      totalPrice: 8,
      userName: '배재광',
      paymentContents: '본인인증'),
  CalcHistoryDetailInfo(
      state: 'complete',
      acceptDate: '2019-04-08 20:48:49',
      paymentPrice: 10,
      paymentMethod: 'kfcbank',
      commission: 1,
      vat: 1,
      totalPrice: 8,
      userName: '배재광',
      paymentContents: '본인인증'),
  CalcHistoryDetailInfo(
      state: 'complete',
      acceptDate: '2019-04-08 20:48:49',
      paymentPrice: 10,
      paymentMethod: 'kfcbank',
      commission: 1,
      vat: 1,
      totalPrice: 8,
      userName: '배재광',
      paymentContents: '본인인증'),
];
