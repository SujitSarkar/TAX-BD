import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_string.dart';
import 'package:tax_bd/src/constant/app_theme.dart';
import 'package:tax_bd/src/feature/auth/provider/auth_provider.dart';
import 'package:tax_bd/src/feature/cost/provider/cost_information_provider.dart';
import 'package:tax_bd/src/feature/home/provider/home_provider.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/financial_asset_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/feature/personal_info/provider/personal_info_provider.dart';
import 'package:tax_bd/src/feature/rebate/provider/rebate_calculation_provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
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
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => SalaryIncomeProvider()),
        ChangeNotifierProvider(create: (context) => AgriculturalIncomeProvider()),
        ChangeNotifierProvider(create: (context) => BusinessIncomeProvider()),
        ChangeNotifierProvider(create: (context) => RebateCalculationProvider()),
        ChangeNotifierProvider(create: (context) => TaxCalculationProvider()),
        ChangeNotifierProvider(create: (context) => CostInformationProvider()),
        ChangeNotifierProvider(create: (context) => FinancialAssetIncomeProvider()),
        ChangeNotifierProvider(create: (context) => RentalIncomeProvider()),
        ChangeNotifierProvider(create: (context) => PersonalInfoProvider()),
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
