import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../model/agriculture_income_input_model.dart';

class AgriculturalIncomeProvider extends ChangeNotifier {
  bool loading = false;
  final TextEditingController nameOfAddressController = TextEditingController();
  final TextEditingController tinController = TextEditingController();

  List<AgricultureIncomeInputModel> agricultureIncomeInputList = [
    AgricultureIncomeInputModel(
        saleTurnoverReceipts: TextEditingController(),
        grossProfit: TextEditingController(),
        generalExpanses: TextEditingController(),
        netProfit: TextEditingController())
  ];

  void addAgricultureIncomeInputListItem() {
    agricultureIncomeInputList.add(AgricultureIncomeInputModel(
        saleTurnoverReceipts: TextEditingController(),
        grossProfit: TextEditingController(),
        generalExpanses: TextEditingController(),
        netProfit: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfAgricultureIncomeInputList(int index){
    agricultureIncomeInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
