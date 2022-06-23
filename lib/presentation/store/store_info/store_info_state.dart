import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/model/franchisee/store.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_info_state.freezed.dart';

part 'store_info_state.g.dart';

@freezed
class StoreInfoState with _$StoreInfoState {
  factory StoreInfoState({
    @Default([]) List<Contact> managers,
    Store? storeData,
    @Default('') String userID,
  }) = _StoreInfoState;

  factory StoreInfoState.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoStateFromJson(json);
}
