import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/components/drawer_widget.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/affiliate/affiliate_info/affiliate_info_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/affiliate/qr_manage/qr_manage_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/calc_history_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/trade_history_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Image.asset(
          'img/home-logo@2x.png',
          width: 120,
        ),
        centerTitle: true,
        actions: const [
          Center(
            child: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: Colors.white,
              size: 25,
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
      case SelectScreenType.calculateHistoryScreen:
        return const CalcHistoryWidget();
      case SelectScreenType.affiliateInfoScreen:
        return const AffiliateInfoWidget();
      case SelectScreenType.qrCodeManageScreen:
        return const QrManageWidget();
      default:
        return const TradeHistoryWidget();
    }
  }
}
