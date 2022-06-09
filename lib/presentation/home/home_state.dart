import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_summary.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

enum SelectScreenType {
  tradeHistoryScreen,
  calculateHistoryScreen,
  affiliateInfoScreen,
  qrCodeManageScreen,
}

enum PeriodType {
  start,
  end,
  qrManage,
  qrDetail,
}

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(SelectScreenType.tradeHistoryScreen)
        SelectScreenType selectScreenType,
    @Default(false) bool isCalendarSelected,
    @Default(PeriodType.start) PeriodType periodType,
    @Default([]) List<FranchiseeManagerInfo> managers,
    @Default([]) List<QrCodeInfo> qrInfoList,
    @Default([]) List<PaymentCompleteInfo> paymentHistoryList,
    @Default([]) List<CalcHistoryDetailInfo> calcDetailInfoList,
    CalcHistorySummary? calcHistorySummary,
    @Default(false) bool isLoadingCalcHistorySearch,
    DateTime? startDay,
    DateTime? endDay,
    DateTime? calcDay,
    DateTime? qrManageEndDay,
    DateTime? qrDetailEndDay,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
