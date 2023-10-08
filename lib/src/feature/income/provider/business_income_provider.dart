import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../model/business_income_input_model.dart';

class BusinessIncomeProvider extends ChangeNotifier {
  bool loading = false;
  final TextEditingController nameOfBusinessController =
      TextEditingController();
  final TextEditingController natureOfBusiness =
      TextEditingController();
  final TextEditingController organizationType =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();

  List<BusinessIncomeInputModel> businessIncomeInputList = [
    BusinessIncomeInputModel(
      saleTurnoverReceipts: TextEditingController(),
      grossProfit: TextEditingController(),
      generalExpanses: TextEditingController(),
      badDebtExpanses: TextEditingController(),
      netProfit: TextEditingController(),
      cashAndBankBalance: TextEditingController(),
      inventory: TextEditingController(),
      fixedAssets: TextEditingController(),
      otherAssets: TextEditingController(),
      totalAssets: TextEditingController(),
      openingCapital: TextEditingController(),
      balanceSheetNetProfit: TextEditingController(),
      drawingDuringIncomeYear: TextEditingController(),
      closingCapital: TextEditingController(),
      liabilities: TextEditingController(),
      totalCapitalAndLiabilities: TextEditingController(),
    )
  ];

  void addBusinessIncomeInputListItem() {
    businessIncomeInputList.add(BusinessIncomeInputModel(
        saleTurnoverReceipts: TextEditingController(),
        grossProfit: TextEditingController(),
        generalExpanses: TextEditingController(),
        badDebtExpanses: TextEditingController(),
        netProfit: TextEditingController(),
        cashAndBankBalance: TextEditingController(),
        inventory: TextEditingController(),
        fixedAssets: TextEditingController(),
        otherAssets: TextEditingController(),
        totalAssets: TextEditingController(),
        openingCapital: TextEditingController(),
        balanceSheetNetProfit: TextEditingController(),
        drawingDuringIncomeYear: TextEditingController(),
        closingCapital: TextEditingController(),
        liabilities: TextEditingController(),
        totalCapitalAndLiabilities: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfBusinessIncomeInputList(int index) {
    businessIncomeInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
