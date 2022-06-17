import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tras_info.freezed.dart';

part 'tras_info.g.dart';

@freezed
class TrasInfo with _$TrasInfo {
  factory TrasInfo({
    String? uname,
    String? payerBirthdayTimestamp,
    String? applicationNo,
    String? buyerName,
    String? payerName,
    String? approvalNo,
    String? calculatedTimestamp,
    String? canceledTimestamp,
    String? productName,
    String? adate,
    String? paymentAmount,
    String? bankName,
    String? cardName,
    String? mname,
    String? paymentMethods,
    String? tstatus,
    String? sname,
    String? orderNo,
    String? gtype,
    String? zip,
    String? payerAddress,
    String? tid,
    int? installment,
  }) = _TrasInfo;

  factory TrasInfo.fromJson(Map<String, dynamic> json) =>
      _$TrasInfoFromJson(json);
}
