import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_string.dart';
import 'package:tax_bd/src/constant/app_theme.dart';
import 'package:tax_bd/src/feature/auth/provider/auth_provider.dart';
import 'package:tax_bd/src/feature/home/provider/home_provider.dart';
import 'package:tax_bd/src/feature/income/provider/income_provider.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/router/app_router_settings.dart';
import 'package:tax_bd/src/shared/app_navigator_key.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(), lazy: true),
        ChangeNotifierProvider(create: (context) => HomeProvider(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => IncomeProvider(), lazy: true),
      ],
      child: MaterialApp(
        navigatorKey: AppNavigatorKey.key,
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        initialRoute: AppRouter.initializer,
        onGenerateRoute: (RouteSettings settings) =>
            GeneratedRoute.onGenerateRoute(settings),
      ),
    );
  }
}
