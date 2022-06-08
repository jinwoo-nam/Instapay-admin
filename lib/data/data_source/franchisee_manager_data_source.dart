import 'package:instapay_admin/core/result.dart';
import 'package:instapay_admin/domain/model/franchisee_manager_info.dart';

class FranchiseeManagerDataSource {
  Future<Result<List<FranchiseeManagerInfo>>> getManagerInfo() async {
    return Result.success(managers);
  }

  Future<void> addManagerInfo(FranchiseeManagerInfo manager) async {
    managers.add(manager);
  }

  Future<void> deleteManagerInfo(int index) async {
    managers.removeAt(index);
  }
}

List<FranchiseeManagerInfo> managers = [
  // FranchiseeManagerInfo(
  //     name: '신정민',
  //     department: '사무국',
  //     email: 'jmin.05@instapay.kr',
  //     phone: '01064512049'),
];
