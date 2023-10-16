import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/foreign_income_input_model.dart';

class ForeignIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<ForeignIncomeInputModel> foreignIncomeInputList = [];

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addForeignInputListItem() {
    foreignIncomeInputList.add(ForeignIncomeInputModel(
      particular: TextEditingController(),
      throughBankingChannel: true
    ));
    notifyListeners();
  }

  void removeItemOfForeignIncomeInputList(int index) async {
    foreignIncomeInputList.removeAt(index);
    await submitForeignIncomeButtonOnTap();
    notifyListeners();
  }

  void changeBankingChannelOrNot(int index, bool newValue) {
    foreignIncomeInputList[index].throughBankingChannel = newValue;
    notifyListeners();
  }

  Future<void> getForeignIncomeData() async {
    foreignIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.foreignIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          foreignIncomeInputList.add(ForeignIncomeInputModel(
            particular: TextEditingController(text: element['particular']),
            throughBankingChannel: element['throughBankingChannel']
          ));
        }
      }
    } else {
      foreignIncomeInputList.add(ForeignIncomeInputModel(
        particular: TextEditingController(),
        throughBankingChannel: true
      ));
    }
    notifyListeners();
  }

  Future<void> submitForeignIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> foreignIncomeDataList = [];

    for (ForeignIncomeInputModel element in foreignIncomeInputList) {
      final Map<String, dynamic> dataMap = {
        'particular': element.particular!.text.trim(),
        'throughBankingChannel' : element.throughBankingChannel
      };
      foreignIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> foreignIncomeDataMap = {
      'data': foreignIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.foreignIncome, data: foreignIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
