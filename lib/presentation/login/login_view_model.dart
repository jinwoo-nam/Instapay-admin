import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/login/login_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/util/constant.dart';

class LoginViewModel with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final TokenUseCase tokenUseCase;

  LoginViewModel({
    required this.loginUseCase,
    required this.tokenUseCase,
  });

  Future<bool> isLoginPass(String id, String pw) async {
    bool result = false;

    var j = {};
    j["wid"] = id;
    j["wpw"] = pw;
    String jsonStr = json.encode(j);

    var byte = utf8.encode(jsonStr);
    var hash = sha256.convert(byte);
    final data = await loginUseCase(loginAid, hash.toString());
    await data.when(success: (data) async {
      if (data["result"] == "ok") {
        result = true;
        await tokenUseCase.saveLoginHash(hash.toString());
        await tokenUseCase.saveToken(data["token"]);
      }
    }, error: (message) {
      print(message);
    });

    String token = await tokenUseCase.loadAccessToken();
    print('token : $token');
    return result;
  }

  void saveAutoLoginState(bool isAutoLogin) async {
    await tokenUseCase.saveIsAutoLogin(isAutoLogin);
  }
}
