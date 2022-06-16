import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';

abstract class ManagerRepository {
  List<Contact> getManagers();

  void setManagers(List<Contact> managers);

  Future<Result<String>> addManagerInfo(Contact manager, String token);

  Future<Result<String>> deleteManagerInfo(int index, String token);
}
