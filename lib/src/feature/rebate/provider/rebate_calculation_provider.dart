import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/rebate_calculation_input_model.dart';

class RebateCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> rebateCalculationFormKey = GlobalKey();
  final TextEditingController nameOfAssesseeController =
      TextEditingController();
  final TextEditingController tinController = TextEditingController();

  List<RebateCalculationInputModel> rebateCalculationInputList = [];

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

  void removeItemOfRebateCalculationInputList(int index) async{
    rebateCalculationInputList.removeAt(index);
    await submitDataButtonOnTap();
    notifyListeners();
    showToast('Item deleted');
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::

  Future<void> getRebateCalculationData() async {
    rebateCalculationInputList = [];

    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.rebateCalculation);

    if (data != null) {
      nameOfAssesseeController.text = data['nameOfAssessee'];
      tinController.text = data['tin'];
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
    if (!rebateCalculationFormKey.currentState!.validate()) {
      return;
    }
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> rebateDataList = [];
    for (RebateCalculationInputModel element in rebateCalculationInputList) {
      final double totalInvestment =
          double.parse(element.lifeInsurance!.text.trim()) +
              double.parse(element.contributionToDepositPerson!.text.trim()) +
              double.parse(element.investmentInGovt!.text.trim()) +
              double.parse(element.investmentInSecurity!.text.trim()) +
              double.parse(element.contributionToProvident!.text.trim()) +
              double.parse(element.selfContribution!.text.trim()) +
              double.parse(element.contributionToApproved!.text.trim()) +
              double.parse(element.contributionToBenevolent!.text.trim()) +
              double.parse(element.contributionToZakat!.text.trim()) +
              double.parse(element.others!.text.trim().isEmpty?'0.0':element.others!.text.trim());

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
    final Map<String, dynamic> rebateDataMap = {
      'nameOfAssessee': nameOfAssesseeController.text.trim(),
      'tin': tinController.text.trim(),
      'data': rebateDataList
    };
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
