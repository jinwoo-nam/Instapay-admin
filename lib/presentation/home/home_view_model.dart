import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_tras_history_use_case.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final GetTrasHistoryUseCase getTrasHistory;

  HomeViewModel({
    required this.getTrasHistory,
  });

  HomeState _state = HomeState();

  HomeState get state => _state;

  void setSelectScreenType(SelectScreenType type) {
    _state = state.copyWith(
      selectScreenType: type,
    );
    notifyListeners();
  }
}
