import 'package:instapay_admin/domain/model/store/contact.dart';
import 'package:instapay_admin/domain/model/store/store.dart';
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
    @Default(false) bool isLoading,
  }) = _StoreInfoState;

  factory StoreInfoState.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoStateFromJson(json);
}
