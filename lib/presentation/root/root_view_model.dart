import 'package:flutter/material.dart';

class RootViewModel with ChangeNotifier {
  bool isSigned = false;

  void setLoginResult(bool res) {
    isSigned = res;
    notifyListeners();
  }
}
