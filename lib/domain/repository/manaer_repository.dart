import 'package:instapay_admin/domain/model/franchisee/contact.dart';

abstract class ManagerRepository {
  Future<void> addManagerInfo(Contact manager);
  Future<void> deleteManagerInfo(int index);
}
