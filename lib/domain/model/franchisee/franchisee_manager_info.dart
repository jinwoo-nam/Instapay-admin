import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchisee_manager_info.freezed.dart';

part 'franchisee_manager_info.g.dart';

@freezed
class FranchiseeManagerInfo with _$FranchiseeManagerInfo {
  factory FranchiseeManagerInfo({
    required String name,
    required String department,
    required String email,
    required String phone,
  }) = _FranchiseeManagerInfo;

  factory FranchiseeManagerInfo.fromJson(Map<String, dynamic> json) =>
      _$FranchiseeManagerInfoFromJson(json);
}
