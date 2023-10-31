import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/asset/provider/asset_info_provider.dart';
import 'package:tax_bd/src/feature/income/model/capital_gain_income_input_model.dart';
import 'package:tax_bd/src/feature/income/model/rental_income_input_model.dart';
import 'package:tax_bd/src/feature/income/model/spouse_children_income_input_model.dart';
import 'package:tax_bd/src/feature/income/provider/capital_gain_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/spouse_children_income_provider.dart';
import 'package:tax_bd/src/feature/rebate/model/rebate_calculation_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../income/model/agriculture_income_input_model.dart';
import '../../income/model/business_income_input_model.dart';
import '../../income/model/financial_asset_income_input_model.dart';
import '../../income/model/foreign_income_input_model.dart';
import '../../income/model/govt_salary_income_input_model.dart';
import '../../income/model/others_income_input_model.dart';
import '../../income/model/partnership_business_income_input_model.dart';
import '../../income/model/private_salary_income_input_model.dart';
import '../../income/provider/agricultural_income_provider.dart';
import '../../income/provider/business_income_provider.dart';
import '../../income/provider/financial_asset_income_provider.dart';
import '../../income/provider/foreign_income_provider.dart';
import '../../income/provider/others_income_provider.dart';
import '../../income/provider/partnership_business_income_provider.dart';
import '../../income/provider/salary_income_provider.dart';
import '../../rebate/provider/rebate_calculation_provider.dart';

class TaxCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  final TextEditingController incomeFromEmployment = TextEditingController();
  final TextEditingController incomeFromRent = TextEditingController();
  final TextEditingController incomeFromAgriculture = TextEditingController();
  final TextEditingController incomeFromBusiness = TextEditingController();
  final TextEditingController incomeFromCapitalGain = TextEditingController();
  final TextEditingController incomeFromFinancialAsset = TextEditingController();
  final TextEditingController incomeFromOtherSource = TextEditingController();
  final TextEditingController incomeFromFirm = TextEditingController();
  final TextEditingController incomeFromMinorOrSpouse = TextEditingController();
  final TextEditingController incomeFromAbroad = TextEditingController();
  final TextEditingController totalIncome = TextEditingController();

  final TextEditingController grossTax = TextEditingController();
  final TextEditingController taxRebate = TextEditingController();
  final TextEditingController netTaxAfterRebate = TextEditingController();
  final TextEditingController minimumTax = TextEditingController();
  final TextEditingController taxPayable = TextEditingController();
  final TextEditingController netWealthSurcharge = TextEditingController();
  final TextEditingController environmentalSurcharge = TextEditingController();
  final TextEditingController delayInterest = TextEditingController();
  final TextEditingController totalAmountPayable = TextEditingController();
  final TextEditingController taxDeductedSource = TextEditingController();
  final TextEditingController advanceTaxPaid = TextEditingController();
  final TextEditingController adjustmentOfTax = TextEditingController();
  final TextEditingController taxPaidWithReturn = TextEditingController();
  final TextEditingController totalTaxPaid = TextEditingController();
  final TextEditingController excessPayment = TextEditingController();
  final TextEditingController taxExempted = TextEditingController();


  void clearAllData() {
    loading = false;
    functionLoading = false;
  }


  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void getAllIncomeData() {

    final BuildContext context = AppNavigatorKey.key.currentState!.context;
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context, listen: false);
    final RentalIncomeProvider rentalIncomeProvider = Provider.of(context, listen: false);
    final AgriculturalIncomeProvider agriculturalIncomeProvider = Provider.of(context, listen: false);
    final BusinessIncomeProvider businessIncomeProvider = Provider.of(context, listen: false);
    final FinancialAssetIncomeProvider financialAssetIncomeProvider = Provider.of(context, listen: false);
    final OthersIncomeProvider othersIncomeProvider = Provider.of(context, listen: false);
    final CapitalGainIncomeProvider capitalGainIncomeProvider = Provider.of(context, listen: false);
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider = Provider.of(context, listen: false);
    final ForeignIncomeProvider foreignIncomeProvider = Provider.of(context, listen: false);
    final SpouseChildrenIncomeProvider spouseChildrenIncomeProvider = Provider.of(context, listen: false);
    final RebateCalculationProvider rebateCalculationProvider = Provider.of(context, listen: false);

    ///Govt Salary Income
    double govtSalaryIncome = 0.0;
    for (GovtSalaryIncomeInputModel element
    in salaryIncomeProvider.govtSalaryIncomeInputList) {
      govtSalaryIncome = govtSalaryIncome +
          double.parse(element.total!.taxable!.text.isNotEmpty
              ? element.total!.taxable!.text.trim()
              : '0.0');
    }
    ///Private Salary Income
    double privateSalaryIncome = 0.0;
    for (PrivateSalaryIncomeInputModel element
    in salaryIncomeProvider.privateSalaryIncomeInputList) {
      privateSalaryIncome = privateSalaryIncome +
          double.parse(element.totalIncomeFromSalary!.text.isNotEmpty
              ? element.totalIncomeFromSalary!.text.trim()
              : '0.0');
    }
    incomeFromEmployment.text = '${govtSalaryIncome + privateSalaryIncome}';

    ///Rent Salary Income
    double rentIncome = 0.0;
    for (RentalIncomeInputModel element
    in rentalIncomeProvider.rentalIncomeInputList) {
      rentIncome = rentIncome +
          double.parse(element.netIncome!.text.isNotEmpty
              ? element.netIncome!.text.trim()
              : '0.0');
    }
    incomeFromRent.text = '$rentIncome';

    ///Agriculture Income
    double agricultureIncome = 0.0;
    for (AgricultureIncomeInputModel element
    in agriculturalIncomeProvider.agricultureIncomeInputList) {
      agricultureIncome = agricultureIncome +
          (double.parse(element.netProfit!.text.isNotEmpty
              ? element.netProfit!.text.trim()
              : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
                  : '0.0'));
    }
    incomeFromAgriculture.text = '$agricultureIncome';

    ///Business Income
    double businessIncome = 0.0;
    for (BusinessIncomeInputModel element
    in businessIncomeProvider.businessIncomeInputList) {
      businessIncome = businessIncome +
          (double.parse(element.netProfit!.text.isNotEmpty
              ? element.netProfit!.text.trim()
              : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
                  : '0.0'));
    }
    incomeFromBusiness.text = '$businessIncome';

    ///Financial Asset Income
    double financialAssetIncome = 0.0;
    //FDR
    for (FDRIncomeItemModel element in financialAssetIncomeProvider.fdrIncomeItemList) {
      financialAssetIncome = financialAssetIncome +
          double.parse(element.total!.text.isNotEmpty
              ? element.total!.text.trim()
              : '0.0');
    }
    //DPS
    for (DPSIncomeItemModel element
    in financialAssetIncomeProvider.dpsIncomeItemList) {
      financialAssetIncome = financialAssetIncome +
          double.parse(element.total!.text.isNotEmpty
              ? element.total!.text.trim()
              : '0.0');
    }
    //Bank
    for (IncomeFromBankItemModel element
    in financialAssetIncomeProvider.incomeFromBankItemList) {
      financialAssetIncome = financialAssetIncome +
          double.parse(element.total!.text.isNotEmpty
              ? element.total!.text.trim()
              : '0.0');
    }
    //Insurance
    for (InsuranceProfitItemModel element
    in financialAssetIncomeProvider.insuranceProfitItemList) {
      financialAssetIncome = financialAssetIncome +
          double.parse(element.total!.text.isNotEmpty
              ? element.total!.text.trim()
              : '0.0');
    }
    //Others
    for (OthersProfitItemModel element
    in financialAssetIncomeProvider.othersProfitItemList) {
      financialAssetIncome = financialAssetIncome +
          (double.parse(element.total!.text.isNotEmpty
              ? element.total!.text
              : '0.0'));
    }
    incomeFromFinancialAsset.text = '$financialAssetIncome';

    ///Others Sector Income
    double otherSectorIncome = 0.0;
    for (OthersIncomeInputModel element
    in othersIncomeProvider.othersIncomeInputList) {
      otherSectorIncome = otherSectorIncome +
          (double.parse(element.particular!.amount!.text.isNotEmpty
              ? element.particular!.amount!.text.trim()
              : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
                  : '0.0'));
    }
    incomeFromOtherSource.text = '$otherSectorIncome';

    ///Capital Gain Income
    double capitalGainIncome = 0.0;
    for (CapitalGainIncomeInputModel element
    in capitalGainIncomeProvider.capitalGainIncomeInputList) {
      capitalGainIncome = capitalGainIncome +
          double.parse(element.gain!.text.isNotEmpty
              ? element.gain!.text.trim()
              : '0.0');
    }
    incomeFromCapitalGain.text = '$capitalGainIncome';

    ///Partnership Income
    double partnershipIncome = 0.0;
    for (PartnershipBusinessIncomeInputModel element
    in partnershipBusinessIncomeProvider
        .partnershipBusinessIncomeInputList) {
      partnershipIncome = partnershipIncome +
          (double.parse(element.totalProfit!.text.isNotEmpty
              ? element.totalProfit!.text.trim()
              : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
                  : '0.0'));
    }
    incomeFromFirm.text = '$partnershipIncome';

    ///Foreign Income
    double foreignIncome = 0.0;
    for (ForeignIncomeInputModel element in foreignIncomeProvider
        .foreignIncomeInputList) {
      if (element.throughBankingChannel == true) {
        foreignIncome = foreignIncome +
            (double.parse(element.particular!.amount!.text.isNotEmpty
                ? element.particular!.amount!.text.trim()
                : '0.0') -
                double.parse(element.exemptedAmount!.text.isNotEmpty
                    ? element.exemptedAmount!.text.trim()
                    : '0.0'));
      } else {
        foreignIncome = foreignIncome +
            (double.parse(element.particular!.amount!.text.isNotEmpty
                ? element.particular!.amount!.text.trim()
                : '0.0'));
      }
    }
    incomeFromAbroad.text = '$foreignIncome';

    ///Spouse Children Income
    double spouseChildrenIncome = 0.0;
    for (SpouseChildrenIncomeInputModel element
    in spouseChildrenIncomeProvider.spouseChildrenIncomeInputList) {
      spouseChildrenIncome = spouseChildrenIncome +
          double.parse(element.particular!.amount!.text.isNotEmpty
              ? element.particular!.amount!.text.trim()
              : '0.0');
    }
    incomeFromMinorOrSpouse.text = '$spouseChildrenIncome';

    ///Rebate
    double rebate = 0.0;
    for (RebateCalculationInputModel element in rebateCalculationProvider
        .rebateCalculationInputList) {
      rebate = rebate + double.parse(element.totalInvestment!.text.isNotEmpty
          ? element.totalInvestment!.text.trim()
          : '0.0');
      taxRebate.text = '$rebate';

      ///Total Income (Aggregate of 1 to 10)
      totalIncome.text = '${govtSalaryIncome + privateSalaryIncome +
          rentIncome +
          agricultureIncome +
          businessIncome +
          capitalGainIncome +
          financialAssetIncome +
          otherSectorIncome +
          partnershipIncome +
          spouseChildrenIncome +
          foreignIncome}';
    }
  }

  void getGrossTaxData(){
    final double grossTaxValue = calculateGrossTax(double.parse(totalIncome.text.isEmpty?'0.0':totalIncome.text));
    grossTax.text = '$grossTaxValue';
  }

  void getMinimumTaxData(){
    //Todo get minimum tax based on tax zone
  }

  void getNetWealthSurchargeData() {
    final BuildContext context = AppNavigatorKey.key.currentState!.context;
    final AssetInfoProvider assetInfoProvider = Provider.of(
        context, listen: false);

    ///Net Tax after Rebate (12–13)
    final double netTaxAfterRebateValue = double.parse(
        grossTax.text.isEmpty
            ? '0.0'
            : grossTax.text.trim()) -
        double.parse(taxRebate.text.isEmpty
            ? '0.0'
            : taxRebate.text.trim());
    netTaxAfterRebate.text = '$netTaxAfterRebateValue';

    ///Tax Payable (Higher of 14 and 15)
    if (netTaxAfterRebateValue > double.parse(
        minimumTax.text.isNotEmpty
            ? minimumTax.text.trim()
            : '0.0')) {
      taxPayable.text = '$netTaxAfterRebateValue';
    } else {
      taxPayable.text = minimumTax.text;
    }

    ///Total Asset
    final double totalAssetsInBdOutsideBdValue = double.parse(
        assetInfoProvider.totalAssetsInBdOutsideBd.text.isNotEmpty
            ? assetInfoProvider.totalAssetsInBdOutsideBd.text.trim()
            : '0.0');

    final double netWealthSurchargeValue = double.parse(taxPayable.text.isEmpty?'0.0':taxPayable.text)
        * calculatePercentOfAsset(totalAssetsInBdOutsideBdValue);
    netWealthSurcharge.text = '$netWealthSurchargeValue';

  }

  Future<void> getTaxCalculationData() async {
    getAllIncomeData();
    getGrossTaxData();
    getMinimumTaxData();
    getNetWealthSurchargeData();

    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(childPath: DbChildPath.taxCalculation);

    if (data != null) {
    // incomeFromEmployment.text = TextEditingController(text: '$incomeFromEmploymentValue'),
    // incomeFromRent: TextEditingController(text: '$incomeFromRentValue'),
    // incomeFromAgriculture: TextEditingController(text: '$incomeFromAgricultureValue'),
    // incomeFromBusiness: TextEditingController(text: '$incomeFromBusinessValue'),
    // incomeFromCapitalGain: TextEditingController(text: '$incomeFromCapitalGainValue'),
    // incomeFromFinancialAsset: TextEditingController(text: '$incomeFromFinancialAssetValue'),
    // incomeFromOtherSource: TextEditingController(text: '$incomeFromOtherSourceValue'),
    // incomeFromFirm: TextEditingController(text: '$incomeFromFirmValue'),
    // incomeFromMinorOrSpouse: TextEditingController(text: '$incomeFromMinorOrSpouseValue'),
    // incomeFromAbroad: TextEditingController(text: '$incomeFromAbroadValue'),
    // totalIncome: TextEditingController(text: '$totalIncomeValue'),
    // taxRebate: TextEditingController(text: '$taxRebateValue'),
    // grossTax.text = data['grossTax'];
    netTaxAfterRebate.text = data['netTaxAfterRebate'];
    // minimumTax.text = data['minimumTax'];
    taxPayable.text = data['taxPayable'];
    // netWealthSurcharge.text = '$totalAssetValue';
    environmentalSurcharge.text = data['environmentalSurcharge'];
    delayInterest.text =data['delayInterest'];
    totalAmountPayable.text =data['totalAmountPayable'];
    taxDeductedSource.text =data['taxDeductedSource'];
    advanceTaxPaid.text =data['advanceTaxPaid'];
    adjustmentOfTax.text =data['adjustmentOfTax'];
    taxPaidWithReturn.text =data['taxPaidWithReturn'];
    totalTaxPaid.text =data['totalTaxPaid'];
    excessPayment.text =data['excessPayment'];
    taxExempted.text = data['taxExempted'];
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    getAllIncomeData();
    getGrossTaxData();
    getMinimumTaxData();
    getNetWealthSurchargeData();

      ///Total Amount Payable (16 + 17 + 18)
      final double totalAmountPayableValue = double.parse(
          taxPayable.text.isEmpty
              ? '0.0'
              : taxPayable.text.trim()) +
          double.parse(netWealthSurcharge.text.isEmpty
              ? '0.0'
              : netWealthSurcharge.text.trim()) +
          double.parse(environmentalSurcharge.text.isEmpty
              ? '0.0'
              : environmentalSurcharge.text.trim()) +
          double.parse(delayInterest.text.isEmpty
              ? '0.0'
              : delayInterest.text.trim());
      totalAmountPayable.text = '$totalAmountPayableValue';

      ///Total Tax Paid and Adjusted (20 + 21 + 22 + 23)
      final double totalTaxPaidValue =
          double.parse(taxDeductedSource.text.isEmpty
              ? '0.0'
              : taxDeductedSource.text.trim()) +
              double.parse(advanceTaxPaid.text.isEmpty
                  ? '0.0'
                  : advanceTaxPaid.text.trim()) +
              double.parse(adjustmentOfTax.text.isEmpty
                  ? '0.0'
                  : adjustmentOfTax.text.trim()) +
              double.parse(taxPaidWithReturn.text.isEmpty
                  ? '0.0'
                  : taxPaidWithReturn.text.trim());
      totalTaxPaid.text = '$totalTaxPaidValue';

      ///Excess Payment (24 – 19)
      final double excessPaymentValue = totalTaxPaidValue -
          totalAmountPayableValue;

      excessPayment.text = '$excessPaymentValue';
      notifyListeners();

      final Map<String, dynamic> taxCalculationDataMap = {
        'incomeFromEmployment': incomeFromEmployment.text,
        'incomeFromRent': incomeFromRent.text,
        'incomeFromAgriculture': incomeFromAgriculture.text,
        'incomeFromBusiness': incomeFromBusiness.text,
        'incomeFromCapitalGain': incomeFromCapitalGain.text,
        'incomeFromFinancialAsset': incomeFromFinancialAsset.text,
        'incomeFromOtherSource': incomeFromOtherSource.text,
        'incomeFromFirm': incomeFromFirm.text,
        'incomeFromMinorOrSpouse': incomeFromMinorOrSpouse.text,
        'incomeFromAbroad': incomeFromAbroad.text,
        'totalIncome': totalIncome.text,
        'grossTax': grossTax.text,
        'taxRebate': taxRebate.text,
        'netTaxAfterRebate': netTaxAfterRebate.text,
        'minimumTax': minimumTax.text,
        'taxPayable': taxPayable.text,
        'netWealthSurcharge': netWealthSurcharge.text,
        'environmentalSurcharge': environmentalSurcharge.text,
        'delayInterest': delayInterest.text,
        'totalAmountPayable': totalAmountPayable.text,
        'taxDeductedSource': taxDeductedSource.text,
        'advanceTaxPaid': advanceTaxPaid.text,
        'adjustmentOfTax': adjustmentOfTax.text,
        'taxPaidWithReturn': taxPaidWithReturn.text,
        'totalTaxPaid': totalTaxPaid.text,
        'excessPayment': excessPayment.text,
        'taxExempted': taxExempted.text,
      };

    await firebaseDbHelper.insertData(childPath: DbChildPath.taxCalculation, data: taxCalculationDataMap)
        .then((result) {
      if (result) {
        showToast('Success');
        AssetInfoProvider assetInfoProvider = Provider.of(
            AppNavigatorKey.key.currentState!.context, listen: false);
        assetInfoProvider.getAllExemptedIncomeExpenseData();
      } else {
        showToast('Failed');
      }
    });

    functionLoading = false;
    notifyListeners();
  }

  double calculateGrossTax(double income) {
    double tax = 0.0;
    if (income <= 350000) {
      tax = 0;
    } else if (income <= 450000) {
      tax = (income - 350000) * 0.05;
    } else if (income <= 750000) {
      tax = 100000 * 0.05 + (income - 450000) * 0.10;
    } else if (income <= 1150000) {
      tax = 100000 * 0.05 + 300000 * 0.10 + (income - 750000) * 0.15;
    } else if (income <= 1650000) {
      tax = 100000 * 0.05 + 300000 * 0.10 + 400000 * 0.15 + (income - 1150000) * 0.20;
    } else {
      tax = 100000 * 0.05 + 300000 * 0.10 + 400000 * 0.15 + 500000 * 0.20 + (income - 1650000) * 0.25;
    }
    return tax;
  }

  double calculatePercentOfAsset(double totalAsset){
    double percentAmount = 1;
    if(totalAsset<=40000000){
      percentAmount = 1;
    }else if(totalAsset>40000000 && totalAsset<=100000000){
      percentAmount = totalAsset * 0.1;
    }
    else if(totalAsset>100000000 && totalAsset<=200000000){
      percentAmount = totalAsset * 0.2;
    }
    else if(totalAsset>200000000 && totalAsset<=500000000){
      percentAmount = totalAsset * 0.3;
    }
    else if(totalAsset>500000000){
      percentAmount = totalAsset * 0.35;
    }

    return percentAmount;
  }
}
