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

  void setPeriodToday() {
    _state = state.copyWith(
      startDay: DateTime.now(),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodWeek() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 7)).year,
          DateTime.now().subtract(const Duration(days: 7)).month,
          DateTime.now().subtract(const Duration(days: 7)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodOneMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 30)).year,
          DateTime.now().subtract(const Duration(days: 30)).month,
          DateTime.now().subtract(const Duration(days: 30)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodTwoMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 60)).year,
          DateTime.now().subtract(const Duration(days: 60)).month,
          DateTime.now().subtract(const Duration(days: 60)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodThreeMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 90)).year,
          DateTime.now().subtract(const Duration(days: 90)).month,
          DateTime.now().subtract(const Duration(days: 90)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }
}
