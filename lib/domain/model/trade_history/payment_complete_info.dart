import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_complete_info.freezed.dart';
part 'payment_complete_info.g.dart';

@freezed
class PaymentCompleteInfo with _$PaymentCompleteInfo {
  factory PaymentCompleteInfo({
    @Default('') String title,
    @Default('') String userName,
    @Default(0) int price,
    @Default('') String paymentInstitution,
    @Default('') String orderNumber,
    @Default('') String paymentDateTime,
  }) = _PaymentCompleteInfo;
  factory PaymentCompleteInfo.fromJson(Map<String, dynamic> json) => _$PaymentCompleteInfoFromJson(json);
}