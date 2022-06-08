import 'package:flutter/material.dart';

class EditQrInfoWidget extends StatelessWidget {
  const EditQrInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR코드 상세'),
      ),
    );
  }
}
