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
}
