import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //set window min size
    WindowManager.instance.setMinimumSize(const Size(780, 500));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iConnect CRM',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.rubik().fontFamily,
        useMaterial3: true,
      ),
      builder:
          (context, child) => Scaffold(
            backgroundColor: Colors.grey.withAlpha(55),
            body: Image.asset('assets/images/logo_iconnect.png'),
          ),
    );
    // This is the theme of your application.
  }
}
