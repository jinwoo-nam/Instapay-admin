import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/home/home_screen.dart';
import 'package:instapay_admin/presentation/login/login_screen.dart';
import 'package:instapay_admin/presentation/root/components/loading_page_widget.dart';
import 'package:instapay_admin/presentation/root/root_view_model.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RootViewModel>();
    return viewModel.isLoadDone == false
        ? const LoadingPageWidget()
        : viewModel.isSigned
            ? const HomeScreen()
            : const LoginScreen();
  }
}
