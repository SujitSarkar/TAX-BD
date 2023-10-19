import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../income/model/agriculture_income_input_model.dart';
import '../../income/model/business_income_input_model.dart';
import '../../income/model/capital_gain_income_input_model.dart';
import '../../income/model/financial_asset_income_input_model.dart';
import '../../income/model/foreign_income_input_model.dart';
import '../../income/model/govt_salary_income_input_model.dart';
import '../../income/model/others_income_input_model.dart';
import '../../income/model/partnership_business_income_input_model.dart';
import '../../income/model/private_salary_income_input_model.dart';
import '../../income/model/rental_income_input_model.dart';
import '../../income/model/spouse_children_income_input_model.dart';
import '../../income/provider/agricultural_income_provider.dart';
import '../../income/provider/business_income_provider.dart';
import '../../income/provider/capital_gain_income_provider.dart';
import '../../income/provider/financial_asset_income_provider.dart';
import '../../income/provider/foreign_income_provider.dart';
import '../../income/provider/others_income_provider.dart';
import '../../income/provider/partnership_business_income_provider.dart';
import '../../income/provider/rental_income_provider.dart';
import '../../income/provider/salary_income_provider.dart';
import '../../income/provider/spouse_children_income_provider.dart';
import '../model/rebate_calculation_input_model.dart';

class RebateCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<RebateCalculationInputModel> rebateCalculationInputList = [];

  double incomeFromEmploymentValue = 0.0;
  double incomeFromRentValue = 0.0;
  double incomeFromAgricultureValue = 0.0;
  double incomeFromBusinessValue = 0.0;
  double incomeFromCapitalGainValue = 0.0;
  double incomeFromFinancialAssetValue = 0.0;
  double incomeFromOtherSourceValue = 0.0;
  double incomeFromFirmValue = 0.0;
  double incomeFromMinorOrSpouseValue = 0.0;
  double incomeFromAbroadValue = 0.0;
  double totalIncomeValue = 0.0;

  void clearAllData(){
    rebateCalculationInputList=[];
    incomeFromEmploymentValue = 0.0;
    incomeFromRentValue = 0.0;
    incomeFromAgricultureValue = 0.0;
    incomeFromBusinessValue = 0.0;
    incomeFromCapitalGainValue = 0.0;
    incomeFromFinancialAssetValue = 0.0;
    incomeFromOtherSourceValue = 0.0;
    incomeFromFirmValue = 0.0;
    incomeFromMinorOrSpouseValue = 0.0;
    incomeFromAbroadValue = 0.0;
    totalIncomeValue = 0.0;

    loading = false;
    functionLoading = false;
  }

  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addRebateCalculationInputListItem() {
    rebateCalculationInputList.add(RebateCalculationInputModel(
        lifeInsurance: TextEditingController(),
        contributionToDepositPerson: TextEditingController(),
        investmentInGovt: TextEditingController(),
        investmentInSecurity: TextEditingController(),
        contributionToProvident: TextEditingController(),
        selfContribution: TextEditingController(),
        contributionToApproved: TextEditingController(),
        contributionToBenevolent: TextEditingController(),
        contributionToZakat: TextEditingController(),
        others: TextEditingController(),
        totalInvestment: TextEditingController(),
        amountOfTax: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfRebateCalculationInputList(int index) async {
    rebateCalculationInputList.removeAt(index);
    await submitDataButtonOnTap();
    notifyListeners();
    showToast('Item deleted');
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void getAllIncomeData() {
    incomeFromEmploymentValue = 0.0;
    incomeFromRentValue = 0.0;
    incomeFromAgricultureValue = 0.0;
    incomeFromBusinessValue = 0.0;
    incomeFromCapitalGainValue = 0.0;
    incomeFromFinancialAssetValue = 0.0;
    incomeFromOtherSourceValue = 0.0;
    incomeFromFirmValue = 0.0;
    incomeFromMinorOrSpouseValue = 0.0;
    incomeFromAbroadValue = 0.0;
    totalIncomeValue = 0.0;

    final BuildContext context = AppNavigatorKey.key.currentState!.context;
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
    final CapitalGainIncomeProvider capitalGainIncomeProvider =
    Provider.of(context, listen: false);
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider =
    Provider.of(context, listen: false);
    final ForeignIncomeProvider foreignIncomeProvider =
    Provider.of(context, listen: false);
    final SpouseChildrenIncomeProvider spouseChildrenIncomeProvider =
    Provider.of(context, listen: false);

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
    ///Rent Salary Income
    double rentIncome = 0.0;
    for (RentalIncomeInputModel element
    in rentalIncomeProvider.rentalIncomeInputList) {
      rentIncome = rentIncome +
          double.parse(element.netIncome!.text.isNotEmpty
              ? element.netIncome!.text.trim()
              : '0.0');
    }
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
    ///Financial Asset Income
    double financialAssetIncome = 0.0;
    //FDR
    for (FDRIncomeItemModel element
    in financialAssetIncomeProvider.fdrIncomeItemList) {
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
    ///Capital Gain Income
    double capitalGainIncome = 0.0;
    for (CapitalGainIncomeInputModel element
    in capitalGainIncomeProvider.capitalGainIncomeInputList) {
      capitalGainIncome = capitalGainIncome +
          double.parse(element.gain!.text.isNotEmpty
              ? element.gain!.text.trim()
              : '0.0');
    }
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
    ///Foreign Income
    double foreignIncome = 0.0;
    for (ForeignIncomeInputModel element in foreignIncomeProvider.foreignIncomeInputList) {
      if(element.throughBankingChannel==true){
        foreignIncome = foreignIncome + (double.parse(element.particular!.amount!.text.isNotEmpty
            ? element.particular!.amount!.text.trim()
            : '0.0') -
            double.parse(element.exemptedAmount!.text.isNotEmpty
                ? element.exemptedAmount!.text.trim()
                : '0.0'));
      }else{
        foreignIncome = foreignIncome + (double.parse(element.particular!.amount!.text.isNotEmpty
            ? element.particular!.amount!.text.trim()
            : '0.0'));
      }

    }
    ///Spouse Children Income
    double spouseChildrenIncome = 0.0;
    for (SpouseChildrenIncomeInputModel element
    in spouseChildrenIncomeProvider.spouseChildrenIncomeInputList) {
      spouseChildrenIncome = spouseChildrenIncome +
          double.parse(element.particular!.amount!.text.isNotEmpty
              ? element.particular!.amount!.text.trim()
              : '0.0');
    }

      incomeFromEmploymentValue = govtSalaryIncome + privateSalaryIncome;
      incomeFromRentValue = rentIncome;
      incomeFromAgricultureValue = agricultureIncome;
      incomeFromBusinessValue = businessIncome;
      incomeFromCapitalGainValue = capitalGainIncome;
      incomeFromFinancialAssetValue = financialAssetIncome;
      incomeFromOtherSourceValue = otherSectorIncome;
      incomeFromFirmValue = partnershipIncome;
      incomeFromMinorOrSpouseValue = spouseChildrenIncome;
      incomeFromAbroadValue = foreignIncome;


      totalIncomeValue = incomeFromEmploymentValue +
          incomeFromRentValue +
          incomeFromAgricultureValue +
          incomeFromBusinessValue +
          incomeFromCapitalGainValue +
          incomeFromFinancialAssetValue +
          incomeFromOtherSourceValue +
          incomeFromFirmValue +
          incomeFromMinorOrSpouseValue +
          incomeFromAbroadValue;
    }


  Future<void> getRebateCalculationData() async {
    rebateCalculationInputList = [];

    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.rebateCalculation);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          rebateCalculationInputList.add(RebateCalculationInputModel(
              lifeInsurance:
                  TextEditingController(text: element['lifeInsurance']),
              contributionToDepositPerson: TextEditingController(
                  text: element['contributionToDepositPerson']),
              investmentInGovt:
                  TextEditingController(text: element['investmentInGovt']),
              investmentInSecurity:
                  TextEditingController(text: element['investmentInSecurity']),
              contributionToProvident: TextEditingController(
                  text: element['contributionToProvident']),
              selfContribution:
                  TextEditingController(text: element['selfContribution']),
              contributionToApproved: TextEditingController(
                  text: element['contributionToApproved']),
              contributionToBenevolent: TextEditingController(
                  text: element['contributionToBenevolent']),
              contributionToZakat:
                  TextEditingController(text: element['contributionToZakat']),
              others: TextEditingController(text: element['others']),
              totalInvestment:
                  TextEditingController(text: element['totalInvestment']),
              amountOfTax:
                  TextEditingController(text: element['amountOfTax'])));
        }
      }
    } else {
      rebateCalculationInputList.add(RebateCalculationInputModel(
          lifeInsurance: TextEditingController(),
          contributionToDepositPerson: TextEditingController(),
          investmentInGovt: TextEditingController(),
          investmentInSecurity: TextEditingController(),
          contributionToProvident: TextEditingController(),
          selfContribution: TextEditingController(),
          contributionToApproved: TextEditingController(),
          contributionToBenevolent: TextEditingController(),
          contributionToZakat: TextEditingController(),
          others: TextEditingController(),
          totalInvestment: TextEditingController(),
          amountOfTax: TextEditingController()));
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    getAllIncomeData();

    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> rebateDataList = [];
    for (RebateCalculationInputModel element in rebateCalculationInputList) {

      final double totalInvestment = double.parse(
              element.lifeInsurance!.text.isNotEmpty
                  ? element.lifeInsurance!.text.trim()
                  : '0.0') +
          double.parse(element.contributionToDepositPerson!.text.isNotEmpty
              ? element.contributionToDepositPerson!.text.trim()
              : '0.0') +
          double.parse(element.investmentInGovt!.text.isNotEmpty
              ? element.investmentInGovt!.text.trim()
              : '0.0') +
          double.parse(element.investmentInSecurity!.text.isNotEmpty
              ? element.investmentInSecurity!.text.trim()
              : '0.0') +
          double.parse(element.contributionToProvident!.text.isNotEmpty
              ? element.contributionToProvident!.text.trim()
              : '0.0') +
          double.parse(element.selfContribution!.text.isNotEmpty
              ? element.selfContribution!.text.trim()
              : '0.0') +
          double.parse(element.contributionToApproved!.text.isNotEmpty
              ? element.contributionToApproved!.text.trim()
              : '0.0') +
          double.parse(element.contributionToBenevolent!.text.isNotEmpty
              ? element.contributionToBenevolent!.text.trim()
              : '0.0') +
          double.parse(element.contributionToZakat!.text.isNotEmpty
              ? element.contributionToZakat!.text.trim()
              : '0.0') +
          double.parse(element.others!.text.trim().isNotEmpty
              ? element.others!.text.trim()
              : '0.0');
      element.totalInvestment!.text = '$totalInvestment';

      double threePercentOfTotalIncome = totalIncomeValue*(3/100);
      double fifteenPercentOfTotalInvestment = totalInvestment*(15/100);
      double tenLacks = 1000000.0;

      double minValue = min(min(threePercentOfTotalIncome, fifteenPercentOfTotalInvestment), tenLacks);
      element.amountOfTax!.text = '$minValue';



      final Map<String, dynamic> dataMap = {
        'lifeInsurance': element.lifeInsurance!.text.trim(),
        'contributionToDepositPerson':
            element.contributionToDepositPerson!.text.trim(),
        'investmentInGovt': element.investmentInGovt!.text.trim(),
        'investmentInSecurity': element.investmentInSecurity!.text.trim(),
        'contributionToProvident': element.contributionToProvident!.text.trim(),
        'selfContribution': element.selfContribution!.text.trim(),
        'contributionToApproved': element.contributionToApproved!.text.trim(),
        'contributionToBenevolent':
            element.contributionToBenevolent!.text.trim(),
        'contributionToZakat': element.contributionToZakat!.text.trim(),
        'others': element.others!.text.trim(),
        'totalInvestment': element.totalInvestment!.text.trim(),
        'amountOfTax': element.amountOfTax!.text.trim()
      };
      rebateDataList.add(dataMap);
    }
    final Map<String, dynamic> rebateDataMap = {'data': rebateDataList};

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.rebateCalculation, data: rebateDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
