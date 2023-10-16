import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/agriculture_income_input_model.dart';

class AgriculturalIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<AgricultureIncomeInputModel> agricultureIncomeInputList = [];

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addAgricultureInputListItem() {
    agricultureIncomeInputList.add(AgricultureIncomeInputModel(
        saleTurnoverReceipt: TextEditingController(),
        grossProfit: TextEditingController(),
        generalExpanses: TextEditingController(),
        netProfit: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfAgricultureIncomeInputList(int index) async {
    agricultureIncomeInputList.removeAt(index);
    await submitAgricultureIncomeButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  Future<void> getAgricultureIncomeData() async {
    agricultureIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.agricultureIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          agricultureIncomeInputList.add(AgricultureIncomeInputModel(
              saleTurnoverReceipt: TextEditingController(text: element['saleTurnoverReceipt']),
              grossProfit: TextEditingController(text: element['grossProfit']),
              generalExpanses: TextEditingController(text: element['generalExpanses']),
              netProfit: TextEditingController(text: element['netProfit'])));
        }
      }
    } else {
      agricultureIncomeInputList.add(
          AgricultureIncomeInputModel(
              saleTurnoverReceipt: TextEditingController(),
              grossProfit: TextEditingController(),
              generalExpanses: TextEditingController(),
              netProfit: TextEditingController())
      );
    }
    notifyListeners();
  }

  Future<void> submitAgricultureIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> agricultureIncomeDataList = [];

    for (AgricultureIncomeInputModel element in agricultureIncomeInputList) {

      final double totalValueOfNetProfit =
          double.parse(element.grossProfit!.text.isEmpty
              ? '0.0'
              : element.grossProfit!.text.trim()) -
              double.parse(element.generalExpanses!.text.isEmpty
                  ? '0.0'
                  : element.generalExpanses!.text.trim());

      element.netProfit!.text = '$totalValueOfNetProfit';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'saleTurnoverReceipt': element.saleTurnoverReceipt!.text.trim(),
        'grossProfit': element.grossProfit!.text.trim(),
        'generalExpanses': element.generalExpanses!.text.trim(),
        'netProfit': element.netProfit!.text.trim()
      };
      agricultureIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> agricultureIncomeDataMap = {
      'data': agricultureIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.agricultureIncome, data: agricultureIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
