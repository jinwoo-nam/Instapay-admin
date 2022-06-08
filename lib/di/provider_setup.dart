import 'package:instapay_admin/data/repository/manager_repository_impl.dart';
import 'package:instapay_admin/data/repository/qr_code_repository_impl.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/get_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  final managerRepository = ManagerRepositoryImpl();
  final qrRepository = QrCodeRepositoryImpl();

  return [
    ChangeNotifierProvider<RootViewModel>(
      create: (context) => RootViewModel(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        managerUseCase: ManagerUseCase(
          getManager: GetManagerUseCase(managerRepository),
          addManager: AddManagerUseCase(managerRepository),
          deleteManager: DeleteManagerUseCase(managerRepository),
        ),
        getQrInfo: GetQrInfoListUseCase(
          qrRepository,
        ),
      ),
    )
  ];
}
