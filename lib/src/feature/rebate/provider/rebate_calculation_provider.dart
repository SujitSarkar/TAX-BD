import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/rebate_calculation_input_model.dart';

class RebateCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<RebateCalculationInputModel> rebateCalculationInputList = [];

  void clearAllData(){
    rebateCalculationInputList=[];
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
