import 'package:flutter/material.dart';
import 'package:instapay_admin/ui/color.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Column(
        children: [
          Text('Copyright © 2020 InstaPay - All Rights Reserved.'),
        ],
      ),
    );
  }
}
