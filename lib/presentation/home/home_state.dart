import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

enum SelectScreenType {
  tradeHistoryScreen,
  trasHistoryScreen,
  storeInfoScreen,
  qrCodeManageScreen,
}

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(SelectScreenType.tradeHistoryScreen)
        SelectScreenType selectScreenType,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
