import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/asset/screen/asset_info_screen.dart';
import 'package:tax_bd/src/feature/home/screen/home_screen.dart';
import 'package:tax_bd/src/feature/income/screen/business_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/capital_gain_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/financial_asset_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/foreign_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/govt_salary_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/income_information_screen.dart';
import 'package:tax_bd/src/feature/income/screen/others_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/partnership_business_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/private_salary_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/rental_income_screen.dart';
import 'package:tax_bd/src/feature/income/screen/spouse_children_income_screen.dart';
import 'package:tax_bd/src/feature/investment/screen/investment_screen.dart';
import 'package:tax_bd/src/feature/personal_info/screen/personal_info_screen.dart';
import '../feature/auth/screen/otp_screen.dart';
import '../feature/auth/screen/signin_screen.dart';
import '../feature/expanse/screen/expense_information_screen.dart';
import '../feature/income/screen/agriculture_income_screen.dart';
import '../feature/splash/splash_screen.dart';
import '../feature/tax/screen/tax_calculation_screen.dart';
import 'app_router.dart';

class GeneratedRoute {
  static PageRouteBuilder onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.initializer:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SplashScreen());
      case AppRouter.home:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const HomeScreen());
      case AppRouter.investmentScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const InvestmentScreen());
      case AppRouter.taxCalculationScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const TaxCalculationScreen());
      case AppRouter.expenseInformationScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const ExpenseInformationScreen());
      case AppRouter.personalInfoScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const PersonalInfoScreen());
      case AppRouter.assetInfoScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const AssetInfoScreen());

      ///Auth Screens
      case AppRouter.signIn:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SignInScreen());
      case AppRouter.otpScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const OtpScreen());

      ///Income Screens
      case AppRouter.incomeInfoScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const IncomeInformationScreen());
      case AppRouter.govtSalaryIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const GovtSalaryIncomeScreen());
      case AppRouter.privateSalaryIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const PrivateSalaryIncomeScreen());
      case AppRouter.agricultureIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const AgricultureIncomeScreen());
      case AppRouter.businessIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const BusinessIncomeScreen());
      case AppRouter.financialAssetIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const FinancialAssetIncomeScreen());
      case AppRouter.rentalIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const RentalIncomeScreen());
      case AppRouter.othersIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const OthersIncomeScreen());
      case AppRouter.spouseChildrenIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const SpouseChildrenIncomeScreen());
      case AppRouter.foreignIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const ForeignIncomeScreen());
      case AppRouter.partnershipBusinessIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const PartnershipBusinessIncomeScreen());
      case AppRouter.capitalGainIncomeScreen:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: slideTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
            const CapitalGainIncomeScreen());

      // case AppRouter.companyDetails:
      //   final Company company = settings.arguments as Company;
      //   return PageRouteBuilder(
      //       settings: settings,
      //       transitionsBuilder: slideTransition,
      //       pageBuilder: (_, animation, secondaryAnimation) =>
      //           CompanyDetailsScreen(
      //             company: company,
      //           ));

      default:
        return PageRouteBuilder(
            settings: settings,
            transitionsBuilder: fadeTransition,
            pageBuilder: (_, animation, secondaryAnimation) =>
                const SplashScreen());
    }
  }

  static const transitionDuration = Duration(milliseconds: 500);

  static Widget fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
