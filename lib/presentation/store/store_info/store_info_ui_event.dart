import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_info_ui_event.freezed.dart';

@freezed
class StoreInfoUiEvent with _$StoreInfoUiEvent {
  const factory StoreInfoUiEvent.showSnackBar(String message) = ShowSnackBar;
}
