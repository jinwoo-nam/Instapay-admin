import 'package:dio/dio.dart';
import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/util/constant.dart';

class LoginDataSource {
  LoginDataSource();

  Future<Result<Map>> login(String aid, String pack) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get(
        loginBaseUrl,
        queryParameters: {'aid': aid, 'pack': pack},
      );
      return Result.success(response.data);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
