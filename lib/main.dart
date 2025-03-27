import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/common/constants.dart';
import 'package:iconnect_crm/core/navigatioin_service.dart';
import 'package:iconnect_crm/presentation/app_module.dart';
import 'package:iconnect_crm/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:iconnect_crm/presentation/cubits/menu_cubit/menu_cubit.dart';
import 'package:iconnect_crm/presentation/cubits/theme_cubit/theme_cubit.dart';
import 'package:iconnect_crm/presentation/pages/base_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //set window min size
    WindowManager.instance.setMinimumSize(const Size(780, 500));
  }
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return runApp(
    ProviderScope(
      // override SharedPreferences provider with correct value
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider).getThemeMode();
    return MaterialApp(
      title: 'iConnect CRM',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      initialRoute: '/products',
      onGenerateRoute: (settings) => NavigationService.generateRoute(settings),
      builder:
          (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider<MenuCubit>(create: (context) => MenuCubit()),
              BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()..loadAllCategories()),
            ],
            child: BasePage(child: child!),
          ),
    );
    // This is the theme of your application.
  }
}
