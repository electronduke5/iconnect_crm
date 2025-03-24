import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconnect_crm/core/navigatioin_service.dart';
import 'package:iconnect_crm/presentation/cubits/menu_cubit/menu_cubit.dart';
import 'package:iconnect_crm/presentation/pages/base_page.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //set window min size
    WindowManager.instance.setMinimumSize(const Size(780, 500));
  }
  runApp(const ProviderScope(child: MyApp()));
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
      initialRoute: '/products',
      onGenerateRoute: (settings) => NavigationService.generateRoute(settings),
      builder:
          (context, child) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<MenuCubit>(create: (context) => MenuCubit(),),
            ],
            child: BasePage(child: child!),
          ),
    );
    // This is the theme of your application.
  }
}
