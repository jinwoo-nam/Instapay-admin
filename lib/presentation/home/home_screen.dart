import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/components/drawer_widget.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_screen.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_screen.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_screen.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

import '../store/store_info/store_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final rootViewModel = context.watch<RootViewModel>();

    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Image.asset(
          'img/home-logo@2x.png',
          width: 120,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
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
