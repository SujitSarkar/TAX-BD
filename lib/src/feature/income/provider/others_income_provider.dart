import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/model/others_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';

class OthersIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> othersIncomeKey = GlobalKey();

  List<OthersIncomeInputModel> othersIncomeInputList = [];

  void clearAllData(){
    othersIncomeInputList=[];
    loading = false;
    functionLoading = false;
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
    if(!othersIncomeKey.currentState!.validate()){
      return;
    }
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

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.othersSectorIncome, data: othersIncomeDataMap).then((result)async{
      if (result) {
        TaxCalculationProvider taxCalculationProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        AssetInfoProvider assetInfoProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        await taxCalculationProvider.getTaxCalculationData();
        await assetInfoProvider.getAssetInfoData();
        showToast('Success');
      } else {
        showToast('Failed');
      }
    });
    functionLoading = false;
    notifyListeners();
  }
}
