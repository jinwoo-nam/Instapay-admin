import 'package:instapay_admin/domain/use_case/franchisee/manager/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/get_manager_use_case.dart';

class ManagerUseCase {
  final GetManagerUseCase getManager;
  final AddManagerUseCase addManager;
  final DeleteManagerUseCase deleteManager;

  ManagerUseCase({
    required this.getManager,
    required this.addManager,
    required this.deleteManager,
  });
}
