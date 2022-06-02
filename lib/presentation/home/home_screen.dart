import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/components/drawer_widget.dart';
import 'package:instapay_admin/ui/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [],
      ),
    );
  }
}
