import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/foreign_income_input_model.dart';
import '../model/others_income_input_model.dart';

class ForeignIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> foreignIncomeKey = GlobalKey();
  List<ForeignIncomeInputModel> foreignIncomeInputList = [];

  void clearAllData(){
    foreignIncomeInputList=[];
    loading = false;
    functionLoading = false;
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
    if(!foreignIncomeKey.currentState!.validate()){
      return;
    }
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

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.foreignIncome, data: foreignIncomeDataMap).then((result){
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
