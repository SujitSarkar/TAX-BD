import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/expanse/model/expense_info_input_model.dart';
import 'package:tax_bd/src/feature/income/model/agriculture_income_input_model.dart';
import 'package:tax_bd/src/feature/income/model/business_income_input_model.dart';
import 'package:tax_bd/src/feature/income/model/foreign_income_input_model.dart';
import 'package:tax_bd/src/feature/income/model/partnership_business_income_input_model.dart';
import 'package:tax_bd/src/feature/income/provider/foreign_income_provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../expanse/provider/expense_information_provider.dart';
import '../../income/model/financial_asset_income_input_model.dart';
import '../../income/model/govt_salary_income_input_model.dart';
import '../../income/model/others_income_input_model.dart';
import '../../income/model/private_salary_income_input_model.dart';
import '../../income/provider/agricultural_income_provider.dart';
import '../../income/provider/business_income_provider.dart';
import '../../income/provider/financial_asset_income_provider.dart';
import '../../income/provider/others_income_provider.dart';
import '../../income/provider/partnership_business_income_provider.dart';
import '../../income/provider/salary_income_provider.dart';

class AssetInfoProvider extends ChangeNotifier{
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  ///Source of found
  final TextEditingController sofTotalIncome = TextEditingController();
  final TextEditingController sofTaxExemptedIncome = TextEditingController();
  final TextEditingController sofReceiptOfGift = TextEditingController();
  final TextEditingController totalSourceOfFund = TextEditingController();
  final TextEditingController netWealthOfPreviousIncomeYear = TextEditingController();
  final TextEditingController sumOfSourceOfFound = TextEditingController();
  final TextEditingController expenseOfLifestyle = TextEditingController();
  final TextEditingController giftExpanseLoss = TextEditingController();
  final TextEditingController totalExpanseAndLoss = TextEditingController();
  final TextEditingController netWealthLastDateOfFinancialYear = TextEditingController();
  ///Personal liabilities Outside BD
  final TextEditingController plobInstLiabilities = TextEditingController();
  final TextEditingController plobNonInstLiabilities = TextEditingController();
  final TextEditingController plobOtherLiabilities = TextEditingController();
  final TextEditingController totalLiabilitiesOutsideBd = TextEditingController();
  final TextEditingController grossWealth = TextEditingController();
  ///Particulars of Assets
  final TextEditingController totalAssetOfBusiness = TextEditingController();
  // final TextEditingController lessBusinessLiabilities = TextEditingController();
  final TextEditingController directorShareholdings = TextEditingController();
  final TextEditingController businessCapitalOfPartnershipFirm = TextEditingController();
  final TextEditingController nonAgriculturalProperty = TextEditingController();
  final TextEditingController agriculturalProperty = TextEditingController();
  ///Financial Assets
  final TextEditingController shareDebentureBondSecurities = TextEditingController();
  final TextEditingController sanchaypatraDepositPensionScheme = TextEditingController();
  final TextEditingController loanGiven = TextEditingController();
  final TextEditingController savingsDeposit = TextEditingController();
  final TextEditingController providentOrOtherFund = TextEditingController();
  final TextEditingController otherInvestment = TextEditingController();
  final TextEditingController totalFinancialAssets = TextEditingController();
  final TextEditingController motorVehicle = TextEditingController();
  final TextEditingController ornaments = TextEditingController();
  final TextEditingController furnitureAndElectronicItems = TextEditingController();
  final TextEditingController otherAsset = TextEditingController();
  ///Cash in Hand and Fund Outside Business
  final TextEditingController bankBalance = TextEditingController();
  final TextEditingController cashInHand = TextEditingController();
  final TextEditingController othersOfCashInHand = TextEditingController();
  final TextEditingController totalCashInHand = TextEditingController();
  final TextEditingController assetOutsideBd = TextEditingController();
  final TextEditingController totalAssetsInBdOutsideBd = TextEditingController();

  void clearAllData(){
    ///Source of found
    sofTotalIncome.clear();
    sofTaxExemptedIncome.clear();
    sofReceiptOfGift.clear();
    totalSourceOfFund.clear();
    netWealthOfPreviousIncomeYear.clear();
    sumOfSourceOfFound.clear();
    expenseOfLifestyle.clear();
    giftExpanseLoss.clear();
    totalExpanseAndLoss.clear();
    netWealthLastDateOfFinancialYear.clear();
    ///Personal liabilities Outside BD
    plobInstLiabilities.clear();
    plobNonInstLiabilities.clear();
    plobOtherLiabilities.clear();
    totalLiabilitiesOutsideBd.clear();
    grossWealth.clear();
    ///Particulars of Assets
    totalAssetOfBusiness.clear();
    // lessBusinessLiabilities.clear();
    directorShareholdings.clear();
    businessCapitalOfPartnershipFirm.clear();
    nonAgriculturalProperty.clear();
    agriculturalProperty.clear();
    ///Financial Assets
    shareDebentureBondSecurities.clear();
    sanchaypatraDepositPensionScheme.clear();
    loanGiven.clear();
    savingsDeposit.clear();
    providentOrOtherFund.clear();
    otherInvestment.clear();
    totalFinancialAssets.clear();
    motorVehicle.clear();
    ornaments.clear();
    furnitureAndElectronicItems.clear();
    otherAsset.clear();
    ///Cash in Hand and Fund Outside Business
    bankBalance.clear();
    cashInHand.clear();
    othersOfCashInHand.clear();
    totalCashInHand.clear();
    assetOutsideBd.clear();
    totalAssetsInBdOutsideBd.clear();

    loading=false;
    functionLoading=false;
  }

  void getAllExemptedIncomeExpenseData(){
    final BuildContext context = AppNavigatorKey.key.currentState!.context;
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context,listen: false);
    final AgriculturalIncomeProvider agriculturalIncomeProvider = Provider.of(context,listen: false);
    final BusinessIncomeProvider businessIncomeProvider = Provider.of(context,listen: false);
    final FinancialAssetIncomeProvider financialAssetIncomeProvider = Provider.of(context,listen: false);
    final OthersIncomeProvider othersIncomeProvider = Provider.of(context,listen: false);
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider = Provider.of(context,listen: false);
    final ForeignIncomeProvider foreignIncomeProvider = Provider.of(context,listen: false);
    final ExpenseInformationProvider expenseInformationProvider = Provider.of(context,listen: false);
    final TaxCalculationProvider taxCalculationProvider = Provider.of(context,listen: false);

    ///Govt Salary Exempted
    double govtSalaryExempted = 0.0;
    for(GovtSalaryIncomeInputModel element in salaryIncomeProvider.govtSalaryIncomeInputList){
      govtSalaryExempted = govtSalaryExempted + double.parse(element.total!.exempted!.text.isNotEmpty
          ? element.total!.exempted!.text
          : '0.0');
    }
    ///Private Salary Exempted
    double privateSalaryExempted = 0.0;
    for(PrivateSalaryIncomeInputModel element in salaryIncomeProvider.privateSalaryIncomeInputList){
      privateSalaryExempted = privateSalaryExempted + double.parse(element.exempted!.text.isNotEmpty
          ? element.exempted!.text
          : '0.0');
    }
    ///Agriculture Exempted
    double agricultureExempted = 0.0;
    for(AgricultureIncomeInputModel element in agriculturalIncomeProvider.agricultureIncomeInputList){
      agricultureExempted = agricultureExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    ///Business Exempted
    double businessExempted = 0.0;
    for(BusinessIncomeInputModel element in businessIncomeProvider.businessIncomeInputList){
      businessExempted = businessExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    ///Financial Asset Exempted
    double financialAssetExempted = 0.0;
    for(OthersProfitItemModel element in financialAssetIncomeProvider.othersProfitItemList){
      financialAssetExempted = financialAssetExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    ///Others Sector Exempted
    double otherSectorExempted = 0.0;
    for(OthersIncomeInputModel element in othersIncomeProvider.othersIncomeInputList){
      otherSectorExempted = otherSectorExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    ///Partnership Exempted
    double partnershipExempted = 0.0;
    for(PartnershipBusinessIncomeInputModel element in partnershipBusinessIncomeProvider.partnershipBusinessIncomeInputList){
      partnershipExempted = partnershipExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    ///Foreign Exempted
    double foreignExempted = 0.0;
    for(ForeignIncomeInputModel element in foreignIncomeProvider.foreignIncomeInputList){
      foreignExempted = foreignExempted + double.parse(element.exemptedAmount!.text.isNotEmpty
          ? element.exemptedAmount!.text
          : '0.0');
    }
    final double taxExemptedIncomeValue = govtSalaryExempted + agricultureExempted
     + businessExempted + financialAssetExempted + otherSectorExempted + partnershipExempted
    + foreignExempted;
    sofTaxExemptedIncome.text = '$taxExemptedIncomeValue';

    ///Tax Calculation Income
    double taxCalculationIncome = 0.0;
      taxCalculationIncome = taxCalculationIncome + double.parse(taxCalculationProvider.totalIncome.text.isNotEmpty
          ? taxCalculationProvider.totalIncome.text
          : '0.0');

    sofTotalIncome.text = '$taxCalculationIncome';

    ///Expense Info
    double expenseInfoValue = 0.0;
    for(ExpenseInformationInputModel element in expenseInformationProvider.expanseInformationInputItemList){
      expenseInfoValue = expenseInfoValue + double.parse(element.total!.text.isNotEmpty
          ? element.total!.text
          : '0.0');
    }
    expenseOfLifestyle.text = '$expenseInfoValue';
    notifyListeners();
  }

  Future<void> getAssetInfoData() async {
    getAllExemptedIncomeExpenseData();

    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.assetInfo);
    if (data != null) {
      // sofTotalIncome.text = '$totalIncomeValue';
      // sofTaxExemptedIncome.text = '$expanseRelatingLifestyleValue';
      sofReceiptOfGift.text = data['sofReceiptOfGift'];
      totalSourceOfFund.text = data['totalSourceOfFund'];
      netWealthOfPreviousIncomeYear.text = data['netWealthOfPreviousIncomeYear'];
      sumOfSourceOfFound.text = data['sumOfSourceOfFound'];
      // expenseOfLifestyle.text = data['expenseOfLifestyle'];
      giftExpanseLoss.text = data['giftExpanseLoss'];
      totalExpanseAndLoss.text = data['totalExpanseAndLoss'];
      netWealthLastDateOfFinancialYear.text = data['netWealthLastDateOfFinancialYear'];
      ///Personal liabilities Outside BD
      plobInstLiabilities.text = data['plobInstLiabilities'];
      plobNonInstLiabilities.text = data['plobNonInstLiabilities'];
      plobOtherLiabilities.text = data['plobOtherLiabilities'];
      totalLiabilitiesOutsideBd.text = data['totalLiabilitiesOutsideBd'];
      grossWealth.text = data['grossWealth'];
      ///Particulars of Assets
      totalAssetOfBusiness.text = data['totalAssetOfBusiness'];
      // lessBusinessLiabilities.text = data['lessBusinessLiabilities'];
      directorShareholdings.text = data['directorShareholdings'];
      businessCapitalOfPartnershipFirm.text = data['businessCapitalOfPartnershipFirm'];
      nonAgriculturalProperty.text = data['nonAgriculturalProperty'];
      agriculturalProperty.text = data['agriculturalProperty'];
      ///Financial Assets
      shareDebentureBondSecurities.text = data['shareDebentureBondSecurities'];
      sanchaypatraDepositPensionScheme.text = data['sanchaypatraDepositPensionScheme'];
      loanGiven.text = data['loanGiven'];
      savingsDeposit.text = data['savingsDeposit'];
      providentOrOtherFund.text = data['providentOrOtherFund'];
      otherInvestment.text = data['otherInvestment'];
      totalFinancialAssets.text = data['totalFinancialAssets'];
      motorVehicle.text = data['motorVehicle'];
      ornaments.text = data['ornaments'];
      furnitureAndElectronicItems.text = data['furnitureAndElectronicItems'];
      otherAsset.text = data['otherAsset'];
      ///Cash in Hand and Fund Outside Business
      bankBalance.text = data['bankBalance'];
      cashInHand.text = data['cashInHand'];
      othersOfCashInHand.text = data['othersOfCashInHand'];
      totalCashInHand.text = data['totalCashInHand'];
      assetOutsideBd.text = data['assetOutsideBd'];
      totalAssetsInBdOutsideBd.text = data['totalAssetsInBdOutsideBd'];
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    ///Total source of found
    final double totalSourceOfFundValue = double.parse(sofTotalIncome.text.isNotEmpty
        ? sofTotalIncome.text
        : '0.0') + double.parse(sofTaxExemptedIncome.text.isNotEmpty
        ? sofTaxExemptedIncome.text
        : '0.0') + double.parse(sofReceiptOfGift.text.isNotEmpty
        ? sofReceiptOfGift.text
        : '0.0');
    totalSourceOfFund.text = '$totalSourceOfFundValue';

    ///Sum of Source of Fund and Previous Year’s Net Wealth (2 +3)
    final double sumOfSourceOfFoundValue = totalSourceOfFundValue + double.parse(netWealthOfPreviousIncomeYear.text.isNotEmpty
        ? netWealthOfPreviousIncomeYear.text
        : '0.0');
    sumOfSourceOfFound.text = '$sumOfSourceOfFoundValue';

    ///Total Expense and Loss
    final double totalExpanseAndLossValue = double.parse(expenseOfLifestyle.text.isNotEmpty
        ? expenseOfLifestyle.text
        : '0.0') + double.parse(giftExpanseLoss.text.isNotEmpty
        ? giftExpanseLoss.text
        : '0.0');
    totalExpanseAndLoss.text = '$totalExpanseAndLossValue';

    ///Net Wealth at the Last Date of this Financial Year (3 – 4)
    final double netWealthLastDateOfFinancialYearValue = sumOfSourceOfFoundValue - totalExpanseAndLossValue;
    netWealthLastDateOfFinancialYear.text = '$netWealthLastDateOfFinancialYearValue';

    ///Total Liabilities Outside Bangladesh
    final double totalLiabilitiesOutsideBdValue = double.parse(plobInstLiabilities.text.isNotEmpty
        ? plobInstLiabilities.text
        : '0.0') + double.parse(plobNonInstLiabilities.text.isNotEmpty
        ? plobNonInstLiabilities.text
        : '0.0') + double.parse(plobOtherLiabilities.text.isNotEmpty
        ? plobOtherLiabilities.text
        : '0.0');
    totalLiabilitiesOutsideBd.text = '$totalLiabilitiesOutsideBdValue';

    ///Gross Wealth (5 + 6)
    final double grossWealthValue = netWealthLastDateOfFinancialYearValue + totalLiabilitiesOutsideBdValue;
    grossWealth.text = '$grossWealthValue';

    ///Less: Business Liabilities
    if(double.parse(plobInstLiabilities.text.isNotEmpty
        ? plobInstLiabilities.text
        : '0.0') < double.parse(plobNonInstLiabilities.text.isNotEmpty
        ? plobNonInstLiabilities.text
        : '0.0')){
      totalAssetOfBusiness.text = plobInstLiabilities.text;
    }else{
      totalAssetOfBusiness.text = plobNonInstLiabilities.text;
    }

    ///Total Financial Assets
    final double totalFinancialAssetsValue = double.parse(shareDebentureBondSecurities.text.isNotEmpty
        ? shareDebentureBondSecurities.text
        : '0.0') + double.parse(sanchaypatraDepositPensionScheme.text.isNotEmpty
        ? sanchaypatraDepositPensionScheme.text
        : '0.0') + double.parse(loanGiven.text.isNotEmpty
        ? loanGiven.text
        : '0.0') + double.parse(savingsDeposit.text.isNotEmpty
        ? savingsDeposit.text
        : '0.0') + double.parse(providentOrOtherFund.text.isNotEmpty
        ? providentOrOtherFund.text
        : '0.0') + double.parse(otherInvestment.text.isNotEmpty
        ? otherInvestment.text
        : '0.0');
    totalFinancialAssets.text = '$totalFinancialAssetsValue';

    ///Total Cash in Hand and Fund Outside Business
    final double totalCashInHandValue = double.parse(bankBalance.text.isNotEmpty
        ? bankBalance.text
        : '0.0') + double.parse(cashInHand.text.isNotEmpty
        ? cashInHand.text
        : '0.0') + double.parse(othersOfCashInHand.text.isNotEmpty
        ? othersOfCashInHand.text
        : '0.0');
    totalCashInHand.text = '$totalCashInHandValue';

    ///Total Assets in Bangladesh and Outside Bangladesh
    final double totalAssetsInBdOutsideBdValue = double.parse(totalAssetOfBusiness.text.isNotEmpty
        ? totalAssetOfBusiness.text
        : '0.0') + double.parse(directorShareholdings.text.isNotEmpty
        ? directorShareholdings.text
        : '0.0') + double.parse(businessCapitalOfPartnershipFirm.text.isNotEmpty
        ? businessCapitalOfPartnershipFirm.text
        : '0.0') + double.parse(nonAgriculturalProperty.text.isNotEmpty
        ? nonAgriculturalProperty.text
        : '0.0') + double.parse(agriculturalProperty.text.isNotEmpty
        ? agriculturalProperty.text
        : '0.0')  + totalFinancialAssetsValue
          + double.parse(motorVehicle.text.isNotEmpty
            ? motorVehicle.text
            : '0.0') + double.parse(ornaments.text.isNotEmpty
            ? ornaments.text
            : '0.0') + double.parse(furnitureAndElectronicItems.text.isNotEmpty
        ? furnitureAndElectronicItems.text
        : '0.0') + double.parse(otherAsset.text.isNotEmpty
        ? otherAsset.text
        : '0.0') + totalCashInHandValue

        + double.parse(assetOutsideBd.text.isNotEmpty
        ? assetOutsideBd.text
        : '0.0');
    totalAssetsInBdOutsideBd.text = '$totalAssetsInBdOutsideBdValue';
    notifyListeners();

    final Map<String, dynamic> assetInfoDataMap = {
    'sofTotalIncome': sofTotalIncome.text.trim(),
    'sofTaxExemptedIncome': sofTaxExemptedIncome.text.trim(),
    'sofReceiptOfGift': sofReceiptOfGift.text.trim(),
    'totalSourceOfFund': totalSourceOfFund.text.trim(),

    'netWealthOfPreviousIncomeYear': netWealthOfPreviousIncomeYear.text.trim(),
    'sumOfSourceOfFound': sumOfSourceOfFound.text.trim(),

    'expenseOfLifestyle': expenseOfLifestyle.text.trim(),
    'giftExpanseLoss': giftExpanseLoss.text.trim(),
    'totalExpanseAndLoss': totalExpanseAndLoss.text.trim(),

    'netWealthLastDateOfFinancialYear': netWealthLastDateOfFinancialYear.text.trim(),

    'plobInstLiabilities': plobInstLiabilities.text.trim(),
    'plobNonInstLiabilities': plobNonInstLiabilities.text.trim(),
    'plobOtherLiabilities': plobOtherLiabilities.text.trim(),
    'totalLiabilitiesOutsideBd': totalLiabilitiesOutsideBd.text.trim(),

    'grossWealth': grossWealth.text.trim(),

    'totalAssetOfBusiness': totalAssetOfBusiness.text.trim(),
    // 'lessBusinessLiabilities': lessBusinessLiabilities.text.trim(),
    'directorShareholdings': directorShareholdings.text.trim(),
    'businessCapitalOfPartnershipFirm': businessCapitalOfPartnershipFirm.text.trim(),
    'nonAgriculturalProperty': nonAgriculturalProperty.text.trim(),
    'agriculturalProperty': agriculturalProperty.text.trim(),

    'shareDebentureBondSecurities': shareDebentureBondSecurities.text.trim(),
    'sanchaypatraDepositPensionScheme': sanchaypatraDepositPensionScheme.text.trim(),
    'loanGiven': loanGiven.text.trim(),
    'savingsDeposit': savingsDeposit.text.trim(),
    'providentOrOtherFund': providentOrOtherFund.text.trim(),
    'otherInvestment': otherInvestment.text.trim(),
    'totalFinancialAssets': totalFinancialAssets.text.trim(),

    'motorVehicle': motorVehicle.text.trim(),
    'ornaments': ornaments.text.trim(),
    'furnitureAndElectronicItems': furnitureAndElectronicItems.text.trim(),
    'otherAsset': otherAsset.text.trim(),
    'bankBalance': bankBalance.text.trim(),
    'cashInHand': cashInHand.text.trim(),
    'othersOfCashInHand': othersOfCashInHand.text.trim(),
    'totalCashInHand': totalCashInHand.text.trim(),

    'assetOutsideBd': assetOutsideBd.text.trim(),
    'totalAssetsInBdOutsideBd': totalAssetsInBdOutsideBd.text.trim()
    };

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.assetInfo, data: assetInfoDataMap).then((result){
      if (result) {
        showToast('Success');
        TaxCalculationProvider taxCalculationProvider = Provider.of(
            AppNavigatorKey.key.currentState!.context, listen: false);
        taxCalculationProvider.getTaxCalculationData();
      } else {
        showToast('Failed');
      }
    });

    functionLoading = false;
    notifyListeners();
  }
}