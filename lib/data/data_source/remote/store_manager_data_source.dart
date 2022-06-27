import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/contact.dart';
import 'package:instapay_admin/util/constant.dart';
import 'package:instapay_admin/util/util.dart';

class StoreManagerDataSource {
  Future<Result<String>> updateManagerInfo(
      List<Contact> manager, String token) async {
    String contact =
        jsonEncode(manager.map((e) => e.toJson()).toList()).toString();
    var payload = {"contacts": jsonDecode(contact)};

    final jwt = encodeJWTWithHS256_Json(payload, token);

    try {
      Response response;
      var dio = Dio();
      dio.options.headers['authorization'] = 'Bearer $token';
      dio.options.contentType = Headers.textPlainContentType;
      response = await dio.put(
        storeBaseUrl,
        data: jwt,
      );
      return Result.success(response.data["result"]);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  List<Contact> getManagers() {
    return managers;
  }

  void setManagers(List<Contact> values) {
    managers = List<Contact>.from(values);
  }

  Future<Result<String>> addManager(Contact value, String token) async {
    managers.add(value);
    return await updateManagerInfo(managers, token);
  }

  Future<Result<String>> deleteManager(int index, String token) async {
    managers.removeAt(index);
    return await updateManagerInfo(managers, token);
  }
}

List<Contact> managers = [];
