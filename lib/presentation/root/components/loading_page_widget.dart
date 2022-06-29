import 'package:flutter/material.dart';

class LoadingPageWidget extends StatelessWidget {
  const LoadingPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: Image.asset(
                'img/home-logo@3x.png',
              ),
            ),
            const SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: LinearProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
