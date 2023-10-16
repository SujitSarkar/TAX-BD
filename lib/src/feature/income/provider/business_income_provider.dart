import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/business_income_input_model.dart';

class BusinessIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<BusinessIncomeInputModel> businessIncomeInputList = [];

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
          )
      );
    }
    notifyListeners();
  }

  Future<void> submitBusinessIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> businessIncomeDataList = [];

    for (BusinessIncomeInputModel element in businessIncomeInputList) {

      final double netProfitValue =
          double.parse(element.grossProfit!.text.isEmpty
              ? '0.0'
              : element.grossProfit!.text.trim()) -
              double.parse(element.generalExpanses!.text.isEmpty
                  ? '0.0'
                  : element.generalExpanses!.text.trim());

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

      final double closingCapitalValue =
          double.parse(element.openingCapital!.text.isEmpty
              ? '0.0'
              : element.openingCapital!.text.trim()) +
              double.parse(element.balanceSheetNetProfit!.text.isEmpty
                  ? '0.0'
                  : element.balanceSheetNetProfit!.text.trim())+
              double.parse(element.drawingDuringIncomeYear!.text.isEmpty
                  ? '0.0'
                  : element.drawingDuringIncomeYear!.text.trim());

      final double totalCapitalAndLiabilitiesValue = closingCapitalValue +
              double.parse(element.liabilities!.text.isEmpty
                  ? '0.0'
                  : element.liabilities!.text.trim());

      element.netProfit!.text = '$netProfitValue';
      element.totalAssets!.text = '$totalAssetValue';
      element.closingCapital!.text = '$closingCapitalValue';
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

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.businessIncome, data: businessIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }

}
