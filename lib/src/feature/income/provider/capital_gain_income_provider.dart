import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../../shared/validator.dart';
import '../model/capital_gain_income_input_model.dart';

class CapitalGainIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<CapitalGainIncomeInputModel> capitalGainIncomeInputList = [];

  ///UI Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> selectAcquisitionDate(int index)async{
    capitalGainIncomeInputList[index].acquisitionDateTime = await showDatePickerAndGetDate();
    capitalGainIncomeInputList[index].acquisitionDateText!.text = DateFormat('dd-MMM-yyyy').format(capitalGainIncomeInputList[index].acquisitionDateTime!);
    notifyListeners();
  }
  Future<void> selectSalesDate(int index)async{
    capitalGainIncomeInputList[index].salesDateTime = await showDatePickerAndGetDate();
    capitalGainIncomeInputList[index].salesDateText!.text = DateFormat('dd-MMM-yyyy').format(capitalGainIncomeInputList[index].salesDateTime!);
    notifyListeners();
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addCapitalGainInputListItem() {
    capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
      particular: TextEditingController(),
      acquisitionDateTime: DateTime.now(),
      acquisitionDateText: TextEditingController(),
      salesDateTime: DateTime.now(),
      salesDateText: TextEditingController(),
      acquisitionValue: TextEditingController(),
      sales: TextEditingController(),
      salesCost: TextEditingController(),
      gain: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfCapitalGainIncomeInputList(int index) async {
    capitalGainIncomeInputList.removeAt(index);
    await submitCapitalGainIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getCapitalGainIncomeData() async {
    capitalGainIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.capitalGainIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
            particular: TextEditingController(text: element['particular']),
            acquisitionDateTime: DateTime.fromMillisecondsSinceEpoch(element['acquisitionDateTime']),
            acquisitionDateText: TextEditingController(text: DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['acquisitionDateTime']))),
            salesDateTime: DateTime.fromMillisecondsSinceEpoch(element['salesDateTime']),
            salesDateText: TextEditingController(text: DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['salesDateTime']))),
            acquisitionValue: TextEditingController(text: element['acquisitionValue']),
            sales: TextEditingController(text: element['sales']),
            salesCost: TextEditingController(text: element['salesCost']),
            gain: TextEditingController(text: element['gain']),
          ));
        }
      }
    } else {
      capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
        particular: TextEditingController(),
        acquisitionDateTime: DateTime.now(),
        acquisitionDateText: TextEditingController(),
        salesDateTime: DateTime.now(),
        salesDateText: TextEditingController(),
        acquisitionValue: TextEditingController(),
        sales: TextEditingController(),
        salesCost: TextEditingController(),
        gain: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitCapitalGainIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> capitalGainIncomeDataList = [];

    for (CapitalGainIncomeInputModel element in capitalGainIncomeInputList) {
      final double gainValue =
          double.parse(element.sales!.text.isEmpty
              ? '0.0'
              : element.sales!.text.trim()) -
              double.parse(element.acquisitionValue!.text.isEmpty
                  ? '0.0'
                  : element.acquisitionValue!.text.trim())-
              double.parse(element.salesCost!.text.isEmpty
              ? '0.0'
              : element.salesCost!.text.trim());

      element.gain!.text = '$gainValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'particular': element.particular!.text.trim(),
        'acquisitionDateTime': element.acquisitionDateTime!.millisecondsSinceEpoch,
        'salesDateTime': element.salesDateTime!.millisecondsSinceEpoch,
        'acquisitionValue': element.acquisitionValue!.text.trim(),
        'sales': element.sales!.text.trim(),
        'salesCost': element.salesCost!.text.trim(),
        'gain': element.gain!.text.trim(),
      };
      capitalGainIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> capitalGainIncomeDataMap = {
      'data': capitalGainIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.capitalGainIncome, data: capitalGainIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
