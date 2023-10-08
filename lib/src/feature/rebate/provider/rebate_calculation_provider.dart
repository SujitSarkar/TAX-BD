import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../model/rebate_calculation_input_model.dart';

class RebateCalculationProvider extends ChangeNotifier {
  bool loading = false;
  final TextEditingController nameOfAddressController = TextEditingController();
  final TextEditingController tinController = TextEditingController();

  List<RebateCalculationInputModel> rebateCalculationInputList = [
    RebateCalculationInputModel(
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
        amountOfTax: TextEditingController())
  ];

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

  void removeItemOfRebateCalculationInputList(int index){
    rebateCalculationInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
