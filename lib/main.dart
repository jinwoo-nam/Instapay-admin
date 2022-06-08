import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instapay_admin/di/provider_setup.dart';
import 'package:instapay_admin/presentation/root/root_screen.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InstaPay Admin',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: const RootScreen(),
    );
  }
}
