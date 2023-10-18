import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/foreign_income_input_model.dart';
import '../model/others_income_input_model.dart';

class ForeignIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<ForeignIncomeInputModel> foreignIncomeInputList = [];

  void clearAllData(){
    foreignIncomeInputList=[];
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addForeignInputListItem() {
    foreignIncomeInputList.add(ForeignIncomeInputModel(
        particular: ParticularInputModel(
          description: TextEditingController(),
          amount: TextEditingController(),
        ),
        exemptedAmount: TextEditingController(),
        throughBankingChannel: true));
    notifyListeners();
  }

  void removeItemOfForeignIncomeInputList(int index) async {
    foreignIncomeInputList.removeAt(index);
    await submitForeignIncomeButtonOnTap();
    notifyListeners();
  }

  void changeBankingChannelOrNot(int index, bool newValue) {
    foreignIncomeInputList[index].throughBankingChannel = newValue;

    if (foreignIncomeInputList[index].throughBankingChannel) {
      foreignIncomeInputList[index].exemptedAmount!.text =
          foreignIncomeInputList[index].particular!.amount!.text;
    }
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
              particular: ParticularInputModel(
                description: TextEditingController(text: element['particular']['description']),
                amount: TextEditingController(text: element['particular']['amount']),
              ),
              exemptedAmount:
                  TextEditingController(text: element['exemptedAmount']),
              throughBankingChannel: element['throughBankingChannel']));
        }
      }
    } else {
      foreignIncomeInputList.add(ForeignIncomeInputModel(
          particular: ParticularInputModel(
            description: TextEditingController(),
            amount: TextEditingController(),
          ), throughBankingChannel: true,exemptedAmount: TextEditingController()));
    }
    notifyListeners();
  }

  Future<void> submitForeignIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> foreignIncomeDataList = [];

    for (ForeignIncomeInputModel element in foreignIncomeInputList) {
      if(element.throughBankingChannel){
        element.exemptedAmount!.text=element.particular!.amount!.text;
      }
      final Map<String, dynamic> dataMap = {
        'particular': {
          'description': element.particular!.description!.text.trim(),
          'amount': element.particular!.amount!.text.trim()
        },
        'throughBankingChannel': element.throughBankingChannel,
        'exemptedAmount':
            element.throughBankingChannel ? element.particular!.amount!.text.trim() : ''
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
