import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/business_income_input_model.dart';

class BusinessIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> businessIncomeKey = GlobalKey();
  List<BusinessIncomeInputModel> businessIncomeInputList = [];

  void clearAllData(){
    businessIncomeInputList=[];
    loading = false;
    functionLoading = false;
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addBusinessInputListItem() {
    businessIncomeInputList.add(BusinessIncomeInputModel(
      nameOfBusiness: TextEditingController(),
      natureOfBusiness: TextEditingController(),
      addressOfBusiness: TextEditingController(),
      saleTurnoverReceipt: TextEditingController(),
      grossProfit: TextEditingController(),
      generalExpanses: TextEditingController(),
      badDebtExpanses: TextEditingController(),
      netProfit: TextEditingController(),
      exemptedAmount: TextEditingController(),
      cashAndBankBalance: TextEditingController(),
      inventory: TextEditingController(),
      fixedAssets: TextEditingController(),
      otherAssets: TextEditingController(),
      totalAssets: TextEditingController(),
      openingCapital: TextEditingController(),
      balanceSheetNetProfit: TextEditingController(),
      drawingDuringIncomeYear: TextEditingController(),
      closingCapital: TextEditingController(),
      liabilities: TextEditingController(),
      totalCapitalAndLiabilities: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfBusinessIncomeInputList(int index) async {
    businessIncomeInputList.removeAt(index);
    await submitBusinessIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getBusinessIncomeData() async {
    businessIncomeInputList = [];
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.businessIncome);
    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          businessIncomeInputList.add(BusinessIncomeInputModel(
            nameOfBusiness: TextEditingController(text: element['nameOfBusiness']),
            natureOfBusiness: TextEditingController(text: element['natureOfBusiness']),
            addressOfBusiness: TextEditingController(text: element['addressOfBusiness']),
            saleTurnoverReceipt: TextEditingController(text: element['saleTurnoverReceipt']),
            grossProfit: TextEditingController(text: element['grossProfit']),
            generalExpanses: TextEditingController(text: element['generalExpanses']),
            badDebtExpanses: TextEditingController(text: element['badDebtExpanses']),
            netProfit: TextEditingController(text: element['netProfit']),
            exemptedAmount: TextEditingController(text: element['exemptedAmount']),
            cashAndBankBalance: TextEditingController(text: element['cashAndBankBalance']),
            inventory: TextEditingController(text: element['inventory']),
            fixedAssets: TextEditingController(text: element['fixedAssets']),
            otherAssets: TextEditingController(text: element['otherAssets']),
            totalAssets: TextEditingController(text: element['totalAssets']),
            openingCapital: TextEditingController(text: element['openingCapital']),
            balanceSheetNetProfit: TextEditingController(text: element['balanceSheetNetProfit']),
            drawingDuringIncomeYear: TextEditingController(text: element['drawingDuringIncomeYear']),
            closingCapital: TextEditingController(text: element['closingCapital']),
            liabilities: TextEditingController(text: element['liabilities']),
            totalCapitalAndLiabilities: TextEditingController(text: element['totalCapitalAndLiabilities']),
          ));
        }
      }
    } else {
      businessIncomeInputList.add(
          BusinessIncomeInputModel(
            nameOfBusiness: TextEditingController(),
            natureOfBusiness: TextEditingController(),
            addressOfBusiness: TextEditingController(),
            saleTurnoverReceipt: TextEditingController(),
            grossProfit: TextEditingController(),
            generalExpanses: TextEditingController(),
            badDebtExpanses: TextEditingController(),
            netProfit: TextEditingController(),
            cashAndBankBalance: TextEditingController(),
            inventory: TextEditingController(),
            fixedAssets: TextEditingController(),
            otherAssets: TextEditingController(),
            totalAssets: TextEditingController(),
            openingCapital: TextEditingController(),
            balanceSheetNetProfit: TextEditingController(),
            drawingDuringIncomeYear: TextEditingController(),
            closingCapital: TextEditingController(),
            liabilities: TextEditingController(),
            totalCapitalAndLiabilities: TextEditingController(),
            exemptedAmount: TextEditingController(),
          )
      );
    }
    notifyListeners();
  }

  Future<void> submitBusinessIncomeButtonOnTap() async {
    if(!businessIncomeKey.currentState!.validate()){
      return;
    }
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> businessIncomeDataList = [];

    for (BusinessIncomeInputModel element in businessIncomeInputList) {

      ///Net Profit (2–3)
      final double netProfitValue =
          double.parse(element.grossProfit!.text.isEmpty
              ? '0.0'
              : element.grossProfit!.text.trim()) -
              double.parse(element.generalExpanses!.text.isEmpty
                  ? '0.0'
                  : element.generalExpanses!.text.trim());
      element.netProfit!.text = '$netProfitValue';

      ///Total Assets (7+8+9+10)
      final double totalAssetValue =
          double.parse(element.cashAndBankBalance!.text.isEmpty
              ? '0.0'
              : element.cashAndBankBalance!.text.trim()) +
              double.parse(element.inventory!.text.isEmpty
                  ? '0.0'
                  : element.inventory!.text.trim())+
              double.parse(element.fixedAssets!.text.isEmpty
              ? '0.0'
              : element.fixedAssets!.text.trim()) +
              double.parse(element.otherAssets!.text.isEmpty
                  ? '0.0'
                  : element.otherAssets!.text.trim());
      element.totalAssets!.text = '$totalAssetValue';

      ///Closing Capital
      final double closingCapitalValue =
          double.parse(element.openingCapital!.text.isEmpty
              ? '0.0'
              : element.openingCapital!.text.trim()) +
              double.parse(element.balanceSheetNetProfit!.text.isEmpty
                  ? '0.0'
                  : element.balanceSheetNetProfit!.text.trim())-
              double.parse(element.drawingDuringIncomeYear!.text.isEmpty
                  ? '0.0'
                  : element.drawingDuringIncomeYear!.text.trim());
      element.closingCapital!.text = '$closingCapitalValue';

      ///Total Capital & Liabilities
      final double totalCapitalAndLiabilitiesValue = closingCapitalValue +
              double.parse(element.liabilities!.text.isEmpty
                  ? '0.0'
                  : element.liabilities!.text.trim());
      element.totalCapitalAndLiabilities!.text = '$totalCapitalAndLiabilitiesValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'nameOfBusiness': element.nameOfBusiness!.text.trim(),
        'natureOfBusiness': element.natureOfBusiness!.text.trim(),
        'addressOfBusiness': element.addressOfBusiness!.text.trim(),
        'saleTurnoverReceipt': element.saleTurnoverReceipt!.text.trim(),
        'grossProfit': element.grossProfit!.text.trim(),
        'generalExpanses': element.generalExpanses!.text.trim(),
        'badDebtExpanses': element.badDebtExpanses!.text.trim(),
        'netProfit': element.netProfit!.text.trim(),
        'exemptedAmount': element.exemptedAmount!.text.trim(),
        'cashAndBankBalance': element.cashAndBankBalance!.text.trim(),
        'inventory': element.inventory!.text.trim(),
        'fixedAssets': element.fixedAssets!.text.trim(),
        'otherAssets': element.otherAssets!.text.trim(),
        'totalAssets': element.totalAssets!.text.trim(),
        'openingCapital': element.openingCapital!.text.trim(),
        'balanceSheetNetProfit': element.balanceSheetNetProfit!.text.trim(),
        'drawingDuringIncomeYear': element.drawingDuringIncomeYear!.text.trim(),
        'closingCapital': element.closingCapital!.text.trim(),
        'liabilities': element.liabilities!.text.trim(),
        'totalCapitalAndLiabilities': element.totalCapitalAndLiabilities!.text.trim(),
      };
      businessIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> businessIncomeDataMap = {
      'data': businessIncomeDataList
    };

   await firebaseDbHelper.insertData(
        childPath: DbChildPath.businessIncome, data: businessIncomeDataMap).then((result)async{
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
