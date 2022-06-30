import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/store/goods.dart';
import 'package:instapay_admin/util/constant.dart';

class QrCodeDataSource {
  Future<Result<List<Goods>>> getQrInfoList(String token) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
        qrBaseUrl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
      );

      if (response.data["result"] == "ok") {
        Iterable jsonResponse = response.data['goods'];
        List<Goods> goods = jsonResponse.map((e) => Goods.fromJson(e)).toList();
        return Result.success(goods);
      } else {
        throw Exception(
            'getQrInfoList result is not ok result : ${response.data["result"]}');
      }
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
