import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/model/spouse_children_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/others_income_input_model.dart';

class SpouseChildrenIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<SpouseChildrenIncomeInputModel> spouseChildrenIncomeInputList = [];

  void clearAllData(){
    spouseChildrenIncomeInputList=[];
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addSpouseChildrenInputListItem() {
    spouseChildrenIncomeInputList.add(SpouseChildrenIncomeInputModel(
      particular: ParticularInputModel(
        description: TextEditingController(),
        amount: TextEditingController(),
      ),
    ));
    notifyListeners();
  }

  void removeItemOfSpouseChildrenIncomeInputList(int index) async {
    spouseChildrenIncomeInputList.removeAt(index);
    await submitSpouseChildrenIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getSpouseChildrenIncomeData() async {
    spouseChildrenIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.spouseChildrenIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          spouseChildrenIncomeInputList.add(SpouseChildrenIncomeInputModel(
            particular: ParticularInputModel(
              description: TextEditingController(text: element['particular']['description']),
              amount: TextEditingController(text: element['particular']['amount']),
            ),
          ));
        }
      }
    } else {
      spouseChildrenIncomeInputList.add(SpouseChildrenIncomeInputModel(
        particular: ParticularInputModel(
          description: TextEditingController(),
          amount: TextEditingController(),
        ),
      ));
    }
    notifyListeners();
  }

  Future<void> submitSpouseChildrenIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> spouseChildrenIncomeDataList = [];

    for (SpouseChildrenIncomeInputModel element in spouseChildrenIncomeInputList) {

      final Map<String, dynamic> dataMap = {
        'particular': {
          'description': element.particular!.description!.text.trim(),
          'amount': element.particular!.amount!.text.trim()
        },
      };
      spouseChildrenIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> spouseChildrenIncomeDataMap = {
      'data': spouseChildrenIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.spouseChildrenIncome, data: spouseChildrenIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
