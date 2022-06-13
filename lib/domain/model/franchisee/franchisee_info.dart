import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'franchisee_info.freezed.dart';
part 'franchisee_info.g.dart';

@freezed
class FranchiseeInfo with _$FranchiseeInfo {
  factory FranchiseeInfo({
    required String title,
    required String category,
    required String ceoName,
    required String businessNumber,
    required String id,
    required String contractDate,
    required String typeOfBusiness,
    required String address,
    required String bankAccount,
    required String nameOfBankUser,
    required String typeOfTrade,
  }) = _FranchiseeInfo;
  factory FranchiseeInfo.fromJson(Map<String, dynamic> json) => _$FranchiseeInfoFromJson(json);
}