import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/tras/tras_history.dart';

abstract class TrasRepository {
  Future<Result<TrasHistory>> getTrasHistory(
      String token, String tid, int limit,
      {String state = ''});
}
