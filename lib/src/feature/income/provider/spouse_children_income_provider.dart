import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/model/spouse_children_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/others_income_input_model.dart';

class SpouseChildrenIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> spouseChildrenIncomeKey = GlobalKey();
  List<SpouseChildrenIncomeInputModel> spouseChildrenIncomeInputList = [];

  void clearAllData(){
    spouseChildrenIncomeInputList=[];
    loading = false;
    functionLoading = false;
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
    if(!spouseChildrenIncomeKey.currentState!.validate()){
      return;
    }
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

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.spouseChildrenIncome, data: spouseChildrenIncomeDataMap).then((result){
      if (result) {
        showToast('Success');
        TaxCalculationProvider taxCalculationProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        AssetInfoProvider assetInfoProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        taxCalculationProvider.getAllIncomeData();
        assetInfoProvider.getAllExemptedIncomeExpenseData();
      } else {
        showToast('Failed');
      }
    });
    functionLoading = false;
    notifyListeners();
  }
}
