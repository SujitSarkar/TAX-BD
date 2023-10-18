import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../model/tax_calculation__input_model.dart';

class TaxCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  List<TaxCalculationInputModel> taxCalculationInputList = [];

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
  double taxRebateValue = 0.0;

  void clearAllData() {
    taxCalculationInputList = [];
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
    taxRebateValue = 0.0;
  }

  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addTaxCalculationInputListItem() {
    taxCalculationInputList.add(
      TaxCalculationInputModel(
        incomeFromEmployment: TextEditingController(text: '$incomeFromEmploymentValue'),
        incomeFromRent: TextEditingController(text: '$incomeFromRentValue'),
        incomeFromAgriculture: TextEditingController(text: '$incomeFromAgricultureValue'),
        incomeFromBusiness: TextEditingController(text: '$incomeFromBusinessValue'),
        incomeFromCapitalGain: TextEditingController(text: '$incomeFromCapitalGainValue'),
        incomeFromFinancialAsset: TextEditingController(text: '$incomeFromFinancialAssetValue'),
        incomeFromOtherSource: TextEditingController(text: '$incomeFromOtherSourceValue'),
        incomeFromFirm: TextEditingController(text: '$incomeFromFirmValue'),
        incomeFromMinorOrSpouse: TextEditingController(text: '$incomeFromMinorOrSpouseValue'),
        incomeFromAbroad: TextEditingController(text: '$incomeFromAbroadValue'),
        totalIncome: TextEditingController(text: '$totalIncomeValue'),
        taxRebate: TextEditingController(text: '$taxRebateValue'),
        grossTax: TextEditingController(),
        netTaxAfterRebate: TextEditingController(),
        minimumTax: TextEditingController(),
        taxPayable: TextEditingController(),
        netWealthSurcharge: TextEditingController(),
        environmentalSurcharge: TextEditingController(),
        delayInterest: TextEditingController(),
        totalAmountPayable: TextEditingController(),
        taxDeductedSource: TextEditingController(),
        advanceTaxPaid: TextEditingController(),
        adjustmentOfTax: TextEditingController(),
        taxPaidWithReturn: TextEditingController(),
        totalTaxPaid: TextEditingController(),
        excessPayment: TextEditingController(),
        taxExempted: TextEditingController(),
      ),
    );
    notifyListeners();
  }

  void removeItemOfTaxCalculationInputList(int index) async {
    taxCalculationInputList.removeAt(index);
    await submitDataButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> getAllIncomeData() async {
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
    final RebateCalculationProvider rebateCalculationProvider = Provider.of(context,listen: false);

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
          double.parse(element.totalRentIncome!.text.isNotEmpty
              ? element.totalRentIncome!.text.trim()
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
                  : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
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
    for (ForeignIncomeInputModel element
        in foreignIncomeProvider.foreignIncomeInputList) {
      foreignIncome = foreignIncome +
          (double.parse(element.particular!.amount!.text.isNotEmpty
                  ? element.particular!.amount!.text.trim()
                  : '0.0') -
              double.parse(element.exemptedAmount!.text.isNotEmpty
                  ? element.exemptedAmount!.text.trim()
                  : '0.0'));
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
    ///Rebate
    double rebate = 0.0;
    for (RebateCalculationInputModel element in rebateCalculationProvider.rebateCalculationInputList) {
      rebate = rebate + double.parse(element.totalInvestment!.text.isNotEmpty
              ? element.totalInvestment!.text.trim()
              : '0.0');

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
    taxRebateValue = rebate;

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
  }

  Future<void> getTaxCalculationData() async {
    await getAllIncomeData();
    taxCalculationInputList = [];

    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.taxCalculation);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          taxCalculationInputList.add(
            TaxCalculationInputModel(
              incomeFromEmployment: TextEditingController(text: '$incomeFromEmploymentValue'),
              incomeFromRent: TextEditingController(text: '$incomeFromRentValue'),
              incomeFromAgriculture: TextEditingController(text: '$incomeFromAgricultureValue'),
              incomeFromBusiness: TextEditingController(text: '$incomeFromBusinessValue'),
              incomeFromCapitalGain: TextEditingController(text: '$incomeFromCapitalGainValue'),
              incomeFromFinancialAsset: TextEditingController(text: '$incomeFromFinancialAssetValue'),
              incomeFromOtherSource: TextEditingController(text: '$incomeFromOtherSourceValue'),
              incomeFromFirm: TextEditingController(text: '$incomeFromFirmValue'),
              incomeFromMinorOrSpouse: TextEditingController(text: '$incomeFromMinorOrSpouseValue'),
              incomeFromAbroad: TextEditingController(text: '$incomeFromAbroadValue'),
              totalIncome: TextEditingController(text: '$totalIncomeValue'),
              taxRebate: TextEditingController(text: '$taxRebateValue'),
              grossTax: TextEditingController(text: element['grossTax']),
              netTaxAfterRebate: TextEditingController(text: element['netTaxAfterRebate']),
              minimumTax: TextEditingController(text: element['minimumTax']),
              taxPayable: TextEditingController(text: element['taxPayable']),
              netWealthSurcharge: TextEditingController(text: element['netWealthSurcharge']),
              environmentalSurcharge: TextEditingController(
                  text: element['environmentalSurcharge']),
              delayInterest:
                  TextEditingController(text: element['delayInterest']),
              totalAmountPayable:
                  TextEditingController(text: element['totalAmountPayable']),
              taxDeductedSource:
                  TextEditingController(text: element['taxDeductedSource']),
              advanceTaxPaid:
                  TextEditingController(text: element['advanceTaxPaid']),
              adjustmentOfTax:
                  TextEditingController(text: element['adjustmentOfTax']),
              taxPaidWithReturn:
                  TextEditingController(text: element['taxPaidWithReturn']),
              totalTaxPaid:
                  TextEditingController(text: element['totalTaxPaid']),
              excessPayment:
                  TextEditingController(text: element['excessPayment']),
              taxExempted: TextEditingController(text: element['taxExempted']),
            ),
          );
        }
      }
    } else {
      taxCalculationInputList.add(
        TaxCalculationInputModel(
          incomeFromEmployment: TextEditingController(text: '$incomeFromEmploymentValue'),
          incomeFromRent: TextEditingController(text: '$incomeFromRentValue'),
          incomeFromAgriculture: TextEditingController(text: '$incomeFromAgricultureValue'),
          incomeFromBusiness: TextEditingController(text: '$incomeFromBusinessValue'),
          incomeFromCapitalGain: TextEditingController(text: '$incomeFromCapitalGainValue'),
          incomeFromFinancialAsset: TextEditingController(text: '$incomeFromFinancialAssetValue'),
          incomeFromOtherSource: TextEditingController(text: '$incomeFromOtherSourceValue'),
          incomeFromFirm: TextEditingController(text: '$incomeFromFirmValue'),
          incomeFromMinorOrSpouse: TextEditingController(text: '$incomeFromMinorOrSpouseValue'),
          incomeFromAbroad: TextEditingController(text: '$incomeFromAbroadValue'),
          totalIncome: TextEditingController(text: '$totalIncomeValue'),
          taxRebate: TextEditingController(text: '$taxRebateValue'),
          grossTax: TextEditingController(),
          netTaxAfterRebate: TextEditingController(),
          minimumTax: TextEditingController(),
          taxPayable: TextEditingController(),
          netWealthSurcharge: TextEditingController(),
          environmentalSurcharge: TextEditingController(),
          delayInterest: TextEditingController(),
          totalAmountPayable: TextEditingController(),
          taxDeductedSource: TextEditingController(),
          advanceTaxPaid: TextEditingController(),
          adjustmentOfTax: TextEditingController(),
          taxPaidWithReturn: TextEditingController(),
          totalTaxPaid: TextEditingController(),
          excessPayment: TextEditingController(),
          taxExempted: TextEditingController(),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> taxCalculationDataList = [];
    for (TaxCalculationInputModel element in taxCalculationInputList) {

      ///Net Tax after Rebate (12–13)
      final double netTaxAfterRebateValue = double.parse(
              element.grossTax!.text.isEmpty
                  ? '0.0'
                  : element.grossTax!.text.trim()) -
          double.parse(element.taxRebate!.text.isEmpty
              ? '0.0'
              : element.taxRebate!.text.trim());

      ///Tax Payable (Higher of 14 and 15)
      if(netTaxAfterRebateValue > double.parse(element.minimumTax!.text.isNotEmpty? element.minimumTax!.text.trim():'0.0')){
        element.taxPayable!.text = '$netTaxAfterRebateValue';
      }else{
        element.taxPayable!.text = element.minimumTax!.text;
      }

      ///Total Amount Payable (16 + 17 + 18)
      final double totalAmountPayableValue = double.parse(
              element.taxPayable!.text.isEmpty
                  ? '0.0'
                  : element.taxPayable!.text.trim()) +
          double.parse(element.netWealthSurcharge!.text.isEmpty
              ? '0.0'
              : element.netWealthSurcharge!.text.trim()) +
          double.parse(element.environmentalSurcharge!.text.isEmpty
              ? '0.0'
              : element.environmentalSurcharge!.text.trim()) +
          double.parse(element.delayInterest!.text.isEmpty
          ? '0.0'
          : element.delayInterest!.text.trim());

      ///Total Tax Paid and Adjusted (20 + 21 + 22 + 23)
      final double totalTaxPaidValue =
          double.parse(element.taxDeductedSource!.text.isEmpty
              ? '0.0'
              : element.taxDeductedSource!.text.trim()) +
          double.parse(element.advanceTaxPaid!.text.isEmpty
              ? '0.0'
              : element.advanceTaxPaid!.text.trim()) +
          double.parse(element.adjustmentOfTax!.text.isEmpty
              ? '0.0'
              : element.adjustmentOfTax!.text.trim())+
          double.parse(element.taxPaidWithReturn!.text.isEmpty
              ? '0.0'
              : element.taxPaidWithReturn!.text.trim());

      ///Excess Payment (24 – 19)
      final double excessPaymentValue = totalTaxPaidValue - totalAmountPayableValue;

      element.totalIncome!.text = '$totalIncomeValue';
      element.netTaxAfterRebate!.text = '$netTaxAfterRebateValue';
      element.totalAmountPayable!.text = '$totalAmountPayableValue';
      element.totalTaxPaid!.text = '$totalTaxPaidValue';
      element.excessPayment!.text = '$excessPaymentValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'incomeFromEmployment': element.incomeFromEmployment!.text,
        'incomeFromRent': element.incomeFromRent!.text,
        'incomeFromAgriculture': element.incomeFromAgriculture!.text,
        'incomeFromBusiness': element.incomeFromBusiness!.text,
        'incomeFromCapitalGain': element.incomeFromCapitalGain!.text,
        'incomeFromFinancialAsset': element.incomeFromFinancialAsset!.text,
        'incomeFromOtherSource': element.incomeFromOtherSource!.text,
        'incomeFromFirm': element.incomeFromFirm!.text,
        'incomeFromMinorOrSpouse': element.incomeFromMinorOrSpouse!.text,
        'incomeFromAbroad': element.incomeFromAbroad!.text,
        'totalIncome': element.totalIncome!.text,
        'grossTax': element.grossTax!.text,
        'taxRebate': element.taxRebate!.text,
        'netTaxAfterRebate': element.netTaxAfterRebate!.text,
        'minimumTax': element.minimumTax!.text,
        'taxPayable': element.taxPayable!.text,
        'netWealthSurcharge': element.netWealthSurcharge!.text,
        'environmentalSurcharge': element.environmentalSurcharge!.text,
        'delayInterest': element.delayInterest!.text,
        'totalAmountPayable': element.totalAmountPayable!.text,
        'taxDeductedSource': element.taxDeductedSource!.text,
        'advanceTaxPaid': element.advanceTaxPaid!.text,
        'adjustmentOfTax': element.adjustmentOfTax!.text,
        'taxPaidWithReturn': element.taxPaidWithReturn!.text,
        'totalTaxPaid': element.totalTaxPaid!.text,
        'excessPayment': element.excessPayment!.text,
        'taxExempted': element.taxExempted!.text,
      };
      taxCalculationDataList.add(dataMap);
    }
    final Map<String, dynamic> taxCalculationDataMap = {
      'data': taxCalculationDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.taxCalculation, data: taxCalculationDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
