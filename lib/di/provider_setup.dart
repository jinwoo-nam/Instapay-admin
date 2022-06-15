import 'package:instapay_admin/data/repository/calc_history_repository_impl.dart';
import 'package:instapay_admin/data/repository/franchisee_repository_impl.dart';
import 'package:instapay_admin/data/repository/login_repository_impl.dart';
import 'package:instapay_admin/data/repository/manager_repository_impl.dart';
import 'package:instapay_admin/data/repository/qr_code_repository_impl.dart';
import 'package:instapay_admin/data/repository/token_repository_impl.dart';
import 'package:instapay_admin/data/repository/trade_history_repository_impl.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_calc_detail_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_calc_history_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/info/get_franchisee_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/add_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/delete_manaer_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/get_manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/login_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/domain/use_case/trade_history/get_payment_history_use_case.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/login/login_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  final managerRepository = ManagerRepositoryImpl();
  final qrRepository = QrCodeRepositoryImpl();
  final tradeRepository = TradeHistoryRepositoryImpl();
  final calcRepository = CalcHistoryRepositoryImpl();
  final franchiseeRepository = FranchiseeRepositoryImpl();
  final loginRepository = LoginRepositoryImpl();
  final tokenRepository = TokenRepositoryImpl();

  return [
    ChangeNotifierProvider<RootViewModel>(
      create: (context) => RootViewModel(),
    ),
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
        loginUseCase: LoginUseCase(loginRepository),
        tokenUseCase: TokenUseCase(tokenRepository),
      ),
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
        getPaymentHistory: GetPaymentHistoryUseCase(tradeRepository),
        getCalcHistory: GetCalcHistoryUseCase(calcRepository),
        getCalcDetailInfo: GetCalcDetailInfoUseCase(calcRepository),
        getFranchiseeInfo: GetFranchiseeInfoUseCase(franchiseeRepository),
      ),
    )
  ];
}
