import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_code_info.freezed.dart';

part 'qr_code_info.g.dart';

@freezed
class QrCodeInfo with _$QrCodeInfo {
  factory QrCodeInfo({
    required String title,
    required int price,
    required String expireDate,
    required String createDate,
    required String state,
  }) = _QrCodeInfo;

  factory QrCodeInfo.fromJson(Map<String, dynamic> json) =>
      _$QrCodeInfoFromJson(json);
}
