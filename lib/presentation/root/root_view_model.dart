import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';

class RootViewModel with ChangeNotifier {
  final TokenUseCase tokenUseCase;
  bool isSigned = false;
  bool isLoadDone = false;

  RootViewModel({
    required this.tokenUseCase,
  }) {
    setIsAutoLogin();
  }

  void setIsAutoLogin() async {
    tokenUseCase.loadIsAutoLogin().then((value) {
      isSigned = value;
      isLoadDone = true;
      notifyListeners();
    });
  }

  void setLoginResult(bool res) {
    isSigned = res;
    if (res == false) {
      tokenUseCase.deleteIsAutoLogin();
      tokenUseCase.deleteAccessToken();
      tokenUseCase.deleteLoginHash();
      tokenUseCase.deleteUserLoginId();
    }
    notifyListeners();
  }
}
