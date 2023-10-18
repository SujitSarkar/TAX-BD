import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_toast.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../router/app_router.dart';
import '../../../shared/local_storage.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/capital_gain_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/financial_asset_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/foreign_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/others_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/partnership_business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/spouse_children_income_provider.dart';
import 'package:tax_bd/src/feature/rebate/provider/rebate_calculation_provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import '../../expanse/provider/expanse_information_provider.dart';
import '../../personal_info/provider/personal_info_provider.dart';

class AuthRepository {

  Future<void> logout() async {
    final BuildContext context = AppNavigatorKey.key.currentState!.context;
    final PersonalInfoProvider personalInfoProvider =
        Provider.of(context, listen: false);
    final RebateCalculationProvider rebateCalculationProvider =
        Provider.of(context, listen: false);
    final ExpanseInformationProvider expanseInformationProvider =
        Provider.of(context, listen: false);
    final TaxCalculationProvider taxCalculationProvider =
        Provider.of(context, listen: false);
    final SalaryIncomeProvider salaryIncomeProvider =
        Provider.of(context, listen: false);
    final RentalIncomeProvider rentalIncomeProvider =
        Provider.of(context, listen: false);
    final AgriculturalIncomeProvider agriculturalIncomeProvider =
        Provider.of(context, listen: false);
    final BusinessIncomeProvider businessIncomeProvider =
        Provider.of(context, listen: false);
    final FinancialAssetIncomeProvider financialAssetIncomeProvider =
        Provider.of(context, listen: false);
    final OthersIncomeProvider othersIncomeProvider =
        Provider.of(context, listen: false);
    final SpouseChildrenIncomeProvider spouseChildrenIncomeProvider =
        Provider.of(context, listen: false);
    final ForeignIncomeProvider foreignIncomeProvider =
        Provider.of(context, listen: false);
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider =
        Provider.of(context, listen: false);
    final CapitalGainIncomeProvider capitalGainIncomeProvider =
        Provider.of(context, listen: false);
    try {
      ///Clear All Data
      personalInfoProvider.clearAllData();
      rebateCalculationProvider.clearAllData();
      expanseInformationProvider.clearAllData();
      taxCalculationProvider.clearAllData();
      salaryIncomeProvider.clearAllData();
      salaryIncomeProvider.clearAllData();
      rentalIncomeProvider.clearAllData();
      agriculturalIncomeProvider.clearAllData();
      businessIncomeProvider.clearAllData();
      financialAssetIncomeProvider.clearAllData();
      othersIncomeProvider.clearAllData();
      spouseChildrenIncomeProvider.clearAllData();
      foreignIncomeProvider.clearAllData();
      partnershipBusinessIncomeProvider.clearAllData();
      capitalGainIncomeProvider.clearAllData();

      await FirebaseAuth.instance.signOut();
      ///Clear Cache
      await clearLocalData().then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouter.signIn, (route) => false);
      });
    } catch (e) {
      debugPrint(e.toString());
      showToast('Logout failed');
    }
  }
}
