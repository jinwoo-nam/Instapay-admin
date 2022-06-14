import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/login/login_use_case.dart';
import 'package:instapay_admin/util/constant.dart';

class LoginViewModel with ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginViewModel({
    required this.loginUseCase,
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
    data.when(
        success: (data) {
          if (data["result"] == "ok") {
            result =  true;
          } else {
            print(data["result"]);
          }
        },
        error: (message) {});

    return result;
  }
}
