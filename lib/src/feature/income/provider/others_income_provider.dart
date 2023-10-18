import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/model/others_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';

class OthersIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<OthersIncomeInputModel> othersIncomeInputList = [];

  void clearAllData(){
    othersIncomeInputList=[];
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addOthersInputListItem() {
    othersIncomeInputList.add(OthersIncomeInputModel(
        particular: ParticularInputModel(
          description: TextEditingController(),
          amount: TextEditingController(),
        ),
        tdsDeducted: TextEditingController(),
        exemptedAmount: TextEditingController()
        ));
    notifyListeners();
  }

  void removeItemOfOthersIncomeInputList(int index) async {
    othersIncomeInputList.removeAt(index);
    await submitOthersIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getOthersIncomeData() async {
    othersIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.othersSectorIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          othersIncomeInputList.add(OthersIncomeInputModel(
            particular: ParticularInputModel(
              description: TextEditingController(text: element['particular']['description']),
              amount: TextEditingController(text: element['particular']['amount']),
          ),
            tdsDeducted: TextEditingController(text: element['tdsDeducted']),
            exemptedAmount: TextEditingController(text: element['exemptedAmount'])
          ));
        }
      }
    } else {
      othersIncomeInputList.add(OthersIncomeInputModel(
        particular: ParticularInputModel(
          description: TextEditingController(),
          amount: TextEditingController(),
        ),
        tdsDeducted: TextEditingController(),
        exemptedAmount: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitOthersIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> othersIncomeDataList = [];

    for (OthersIncomeInputModel element in othersIncomeInputList) {

      final Map<String, dynamic> dataMap = {
        'particular': {
          'description': element.particular!.description!.text.trim(),
          'amount': element.particular!.amount!.text.trim()
        },
        'tdsDeducted': element.tdsDeducted!.text.trim(),
        'exemptedAmount': element.exemptedAmount!.text.trim(),
      };
      othersIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> othersIncomeDataMap = {
      'data': othersIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.othersSectorIncome, data: othersIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
