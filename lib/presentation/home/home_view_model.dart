import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel();

  HomeState _state = HomeState();

  HomeState get state => _state;

  void setSelectScreenType(SelectScreenType type) {
    _state = state.copyWith(
      selectScreenType: type,
    );
    notifyListeners();
  }

  void setCalendarSelectState(bool selected, PeriodType type) {
    _state = state.copyWith(
      isCalendarSelected: selected,
      periodType: type,
    );
    notifyListeners();
  }

  void setSelectedDay(DateTime selectedDay) {
    if (state.periodType == PeriodType.start) {
      _state = state.copyWith(
        startDay: selectedDay,
        isCalendarSelected: false,
      );
    } else {
      _state = state.copyWith(
        endDay: selectedDay,
        isCalendarSelected: false,
      );
    }

    notifyListeners();
  }
}
