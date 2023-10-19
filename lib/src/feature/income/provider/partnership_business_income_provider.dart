import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/partnership_business_income_input_model.dart';

class PartnershipBusinessIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> partnershipBusinessIncomeKey = GlobalKey();
  List<PartnershipBusinessIncomeInputModel> partnershipBusinessIncomeInputList = [];

  void clearAllData(){
    partnershipBusinessIncomeInputList=[];
    loading = false;
    functionLoading = false;
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addPartnershipBusinessInputListItem() {
    partnershipBusinessIncomeInputList.add(PartnershipBusinessIncomeInputModel(
      nameOfBusiness: TextEditingController(),
        taxPaid: TextEditingController(),
        profit: TextEditingController(),
        salaryDiscountCommission: TextEditingController(),
        totalProfit: TextEditingController(),
        exemptedAmount: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfPartnershipBusinessIncomeInputList(int index) async {
    partnershipBusinessIncomeInputList.removeAt(index);
    await submitPartnershipBusinessIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getPartnershipBusinessIncomeData() async {
    partnershipBusinessIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.partnershipBusinessIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          partnershipBusinessIncomeInputList.add(PartnershipBusinessIncomeInputModel(
            nameOfBusiness: TextEditingController(text: element['nameOfBusiness']),
            taxPaid: TextEditingController(text: element['taxPaid']),
            profit: TextEditingController(text: element['profit']),
            salaryDiscountCommission: TextEditingController(text: element['salaryDiscountCommission']),
            totalProfit: TextEditingController(text: element['totalProfit']),
            exemptedAmount: TextEditingController(text: element['exemptedAmount']),
          ));
        }
      }
    } else {
      partnershipBusinessIncomeInputList.add(PartnershipBusinessIncomeInputModel(
        nameOfBusiness: TextEditingController(),
        profit: TextEditingController(),
        taxPaid: TextEditingController(),
        salaryDiscountCommission: TextEditingController(),
        totalProfit: TextEditingController(),
        exemptedAmount: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitPartnershipBusinessIncomeButtonOnTap() async {
    if(!partnershipBusinessIncomeKey.currentState!.validate()){
      return;
    }
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> partnershipBusinessIncomeDataList = [];

    for (PartnershipBusinessIncomeInputModel element in partnershipBusinessIncomeInputList) {
      final double totalProfitValue =
          double.parse(element.profit!.text.isEmpty
              ? '0.0'
              : element.profit!.text.trim()) +
              double.parse(element.salaryDiscountCommission!.text.isEmpty
                  ? '0.0'
                  : element.salaryDiscountCommission!.text.trim());

      element.totalProfit!.text = '$totalProfitValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'nameOfBusiness': element.nameOfBusiness!.text.trim(),
        'profit': element.profit!.text.trim(),
        'taxPaid': element.taxPaid!.text.trim(),
        'salaryDiscountCommission': element.salaryDiscountCommission!.text.trim(),
        'totalProfit': element.totalProfit!.text.trim(),
        'exemptedAmount': element.exemptedAmount!.text.trim(),
      };
      partnershipBusinessIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> partnershipBusinessIncomeDataMap = {
      'data': partnershipBusinessIncomeDataList
    };

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.partnershipBusinessIncome, data: partnershipBusinessIncomeDataMap).then((result)async{
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
