import 'package:instapay_admin/domain/model/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/model/qr_code_info.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    DateTime? startDay,
    DateTime? endDay,
    DateTime? calcDay,
    DateTime? qrManageEndDay,
    DateTime? qrDetailEndDay,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
