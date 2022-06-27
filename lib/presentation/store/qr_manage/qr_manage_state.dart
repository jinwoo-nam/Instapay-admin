import 'package:instapay_admin/domain/model/store/goods.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_manage_state.freezed.dart';

part 'qr_manage_state.g.dart';

@freezed
class QrManageState with _$QrManageState {
  factory QrManageState({
    @Default(false) bool isQrManageCalendarSelected,
    @Default(false) bool isStartDateCalendarSelected,
    @Default(false) bool isQrDetailCalendarSelected,
    @Default(false) bool isQrCreateCalendarSelected,
    @Default(false) bool isLoadingQrManageSearch,
    @Default([]) List<Goods> qrInfoList,
    DateTime? qrManageStartDay,
    DateTime? qrManageEndDay,
    DateTime? qrDetailEndDay,
    DateTime? qrCreateEndDay,
  }) = _QrManageState;

  factory QrManageState.fromJson(Map<String, dynamic> json) =>
      _$QrManageStateFromJson(json);
}
