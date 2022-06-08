import 'package:instapay_admin/data/repository/manager_repository_impl.dart';
import 'package:instapay_admin/domain/use_case/franchisee/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/get_manager_use_case.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  final repository = ManagerRepositoryImpl();

  return [
    ChangeNotifierProvider<RootViewModel>(
      create: (context) => RootViewModel(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        getManager: GetManagerUseCase(repository),
        addManager: AddManagerUseCase(repository),
        deleteManager: DeleteManagerUseCase(repository),
      ),
    )
  ];
}
