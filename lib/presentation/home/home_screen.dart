import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/components/drawer_widget.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_screen.dart';
import 'package:instapay_admin/presentation/store/store_info/store_info_view_model.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_screen.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_screen.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

import '../store/store_info/store_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FToast fToast;
  late Widget toast;

  _removeToast() {
    fToast.removeCustomToast();
  }

  _showToast(String message) {
    _removeToast();

    fToast.showToast(
      child: Container(
          width: 250,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(message),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          fToast = FToast();
          fToast.init(context);
        },
      );
    });
    final storeInfoViewModel = context.read<StoreInfoViewModel>();
    final rootViewModel = context.read<RootViewModel>();
    storeInfoViewModel.getStoreInfoList().then((value) {
      if (!value) {
        print('logout');
        rootViewModel.setLoginResult(false);
        _showToast('로그인이 만료되었습니다.\n다시 로그인 해주세요.');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final rootViewModel = context.watch<RootViewModel>();

    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: SizedBox(
          width: 120,
          child: Image.asset(
            'img/home-logo@3x.png',
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              viewModel
                  .setSelectScreenType(SelectScreenType.tradeHistoryScreen);
              rootViewModel.setLoginResult(false);
            },
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: getScreen(state.selectScreenType),
    );
  }

  Widget getScreen(SelectScreenType type) {
    switch (type) {
      case SelectScreenType.trasHistoryScreen:
        return const TrasHistoryScreen();
      case SelectScreenType.storeInfoScreen:
        return const StoreInfoScreen();
      case SelectScreenType.qrCodeManageScreen:
        return const QrManageScreen();
      default:
        return const TradeHistoryScreen();
    }
  }
}
