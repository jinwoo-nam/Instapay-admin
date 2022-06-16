import 'package:instapay_admin/domain/use_case/franchisee/manager/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/get_managers_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/set_manager_use_case.dart';

class ManagerUseCase {
  final GetManagersUseCase getManagers;
  final SetManagerUseCase setManagers;
  final AddManagerUseCase addManager;
  final DeleteManagerUseCase deleteManager;

  ManagerUseCase({
    required this.getManagers,
    required this.setManagers,
    required this.addManager,
    required this.deleteManager,
  });
}
