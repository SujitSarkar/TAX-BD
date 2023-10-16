import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_string.dart';
import 'package:tax_bd/src/constant/app_theme.dart';
import 'package:tax_bd/src/feature/auth/provider/auth_provider.dart';
import 'package:tax_bd/src/feature/expanse/provider/expanse_information_provider.dart';
import 'package:tax_bd/src/feature/home/provider/home_provider.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/capital_gain_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/financial_asset_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/foreign_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/others_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/partnership_business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/spouse_children_income_provider.dart';
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
        ChangeNotifierProvider(create: (context) => AuthProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => HomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => PersonalInfoProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => SalaryIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => AgriculturalIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => BusinessIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => RebateCalculationProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => TaxCalculationProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => ExpanseInformationProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => FinancialAssetIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => RentalIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => OthersIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => SpouseChildrenIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => ForeignIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => PartnershipBusinessIncomeProvider(),lazy: true),
        ChangeNotifierProvider(create: (context) => CapitalGainIncomeProvider(),lazy: true),
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
