import 'package:dio/dio.dart';
import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/tras/tras_history.dart';
import 'package:instapay_admin/util/constant.dart';

class TrasDataSource {
  Future<Result<TrasHistory>> getTrasHistory(
      String token, String tid, int limit,
      {String state = ''}) async {
    try {
      Response response;
      var dio = Dio();
      dio.options.headers['authorization'] = 'Bearer $token';
      response = await dio.get(
        trasBaseUrl,
        queryParameters: {'offset': tid, 'limit': limit, 'state': state},
      );

      print(response.data);
      if (response.data["result"] == "ok") {
        TrasHistory history = TrasHistory.fromJson(response.data);
        return Result.success(history);
      } else {
        return Result.error('getTrasHistory result is not ok result : ${response.data["result"]}');
      }
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
