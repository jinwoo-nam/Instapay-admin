import 'package:freezed_annotation/freezed_annotation.dart';

part 'calc_history_detail_info.freezed.dart';

part 'calc_history_detail_info.g.dart';

@freezed
class CalcHistoryDetailInfo with _$CalcHistoryDetailInfo {
  factory CalcHistoryDetailInfo({
    required String state,
    required String acceptDate,
    required int paymentPrice,
    required String paymentMethod,
    required int commission,
    required int vat,
    required int totalPrice,
    required String userName,
    required String paymentContents,
  }) = _CalcHistoryDetailInfo;

  factory CalcHistoryDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$CalcHistoryDetailInfoFromJson(json);
}
