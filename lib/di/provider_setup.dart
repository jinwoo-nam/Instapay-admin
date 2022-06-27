import 'package:instapay_admin/data/repository/calc_history_repository_impl.dart';
import 'package:instapay_admin/data/repository/store_repository_impl.dart';
import 'package:instapay_admin/data/repository/login_repository_impl.dart';
import 'package:instapay_admin/data/repository/manager_repository_impl.dart';
import 'package:instapay_admin/data/repository/qr_code_repository_impl.dart';
import 'package:instapay_admin/data/repository/token_repository_impl.dart';
import 'package:instapay_admin/data/repository/trade_history_repository_impl.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_tras_history_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/login_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/info/get_franchisee_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/manager/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/manager/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/manager/get_managers_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/manager/set_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/domain/use_case/trade_history/get_payment_history_use_case.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/login/login_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_view_model.dart';
import 'package:instapay_admin/presentation/store/store_info/store_info_view_model.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_view_model.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  final managerRepository = ManagerRepositoryImpl();
  final qrRepository = QrCodeRepositoryImpl();
  final tradeRepository = TradeHistoryRepositoryImpl();
  final trasRepository = TrasHistoryRepositoryImpl();
  final storeRepository = StoreRepositoryImpl();
  final loginRepository = LoginRepositoryImpl();
  final tokenRepository = TokenRepositoryImpl();

  final tokenUseCase = TokenUseCase(tokenRepository);

  return [
    ChangeNotifierProvider<RootViewModel>(
      create: (context) => RootViewModel(
        tokenUseCase: tokenUseCase,
      ),
    ),
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        loginUseCase: LoginUseCase(loginRepository),
        tokenUseCase: tokenUseCase,
      ),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
    ),
    ChangeNotifierProvider<QrManageViewModel>(
      create: (context) => QrManageViewModel(
        getQrInfo: GetQrInfoListUseCase(qrRepository),
        tokenUseCase: tokenUseCase,
      ),
    ),
    ChangeNotifierProvider<StoreInfoViewModel>(
      create: (context) => StoreInfoViewModel(
        managerUseCase: ManagerUseCase(
          getManagers: GetManagersUseCase(managerRepository),
          setManagers: SetManagerUseCase(managerRepository),
          addManager: AddManagerUseCase(managerRepository),
          deleteManager: DeleteManagerUseCase(managerRepository),
        ),
        tokenUseCase: tokenUseCase,
        getFranchiseeInfo: GetStoreInfoUseCase(storeRepository),
      ),
    ),
    ChangeNotifierProvider<TradeHistoryViewModel>(
      create: (context) => TradeHistoryViewModel(
        getPaymentHistory: GetPaymentHistoryUseCase(tradeRepository),
      ),
    ),
    ChangeNotifierProvider<TrasHistoryViewModel>(
      create: (context) => TrasHistoryViewModel(
        tokenUseCase: tokenUseCase,
        getTrasHistory: GetTrasHistoryUseCase(trasRepository),
      ),
    ),
  ];
}
