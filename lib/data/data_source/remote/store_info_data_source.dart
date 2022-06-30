import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/store.dart';
import 'package:instapay_admin/util/constant.dart';

class StoreInfoDataSource {
  Future<Result<Store>> getStoreInfo(String token) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
        storeBaseUrl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
      );

      print(response.data);
      if (response.data["result"] == "ok") {
        Store store = Store.fromJson(response.data["store"]);
        return Result.success(store);
      } else {
        throw Exception(
            'getStoreInfo result is not ok result : ${response.data["result"]}');
      }
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
