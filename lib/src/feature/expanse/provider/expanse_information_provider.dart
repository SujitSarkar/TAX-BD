import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/expanse_info_input_model.dart';

class ExpanseInformationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  bool deleteButtonOnTap = false;

  List<ExpanseInformationInputModel> expanseInformationInputItemList = [];

  void clearAllData(){
    expanseInformationInputItemList=[];
  }
  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addCostInformationInputListItem() {
    expanseInformationInputItemList.add(ExpanseInformationInputModel(
      personalAndFoodingExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      houseExpanse: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      personalTransportExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      utilityExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      educationExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      personalExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      festivalExpanses: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      taxDeduction: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      interestPaid: ExpanseInformationInputModelItem(
          amount: TextEditingController(), comment: TextEditingController()),
      total: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfCostInformationInputList(int index) async {
    expanseInformationInputItemList.removeAt(index);
    await submitDataButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> getCostInfoData() async {
    expanseInformationInputItemList = [];

    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.expanseInformation);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          expanseInformationInputItemList.add(ExpanseInformationInputModel(
            personalAndFoodingExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['personalAndFoodingExpanses']['amount']),
                comment: TextEditingController(
                    text: element['personalAndFoodingExpanses']['comment'])),
            houseExpanse: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['houseExpanses']['amount']),
                comment: TextEditingController(
                    text: element['houseExpanses']['comment'])),
            personalTransportExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['personalTransportExpanses']['amount']),
                comment: TextEditingController(
                    text: element['personalTransportExpanses']['comment'])),
            utilityExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['utilityExpanses']['amount']),
                comment: TextEditingController(
                    text: element['utilityExpanses']['comment'])),
            educationExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['educationExpanses']['amount']),
                comment: TextEditingController(
                    text: element['educationExpanses']['comment'])),
            personalExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['personalExpanses']['amount']),
                comment: TextEditingController(
                    text: element['personalExpanses']['comment'])),
            festivalExpanses: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['festivalExpanses']['amount']),
                comment: TextEditingController(
                    text: element['festivalExpanses']['comment'])),
            taxDeduction: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['taxDeduction']['amount']),
                comment: TextEditingController(
                    text: element['taxDeduction']['comment'])),
            interestPaid: ExpanseInformationInputModelItem(
                amount: TextEditingController(
                    text: element['interestPaid']['amount']),
                comment: TextEditingController(
                    text: element['interestPaid']['comment'])),
            total: TextEditingController(text: element['total']),
          ));
        }
      }
    } else {
      expanseInformationInputItemList.add(ExpanseInformationInputModel(
        personalAndFoodingExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        houseExpanse: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        personalTransportExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        utilityExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        educationExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        personalExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        festivalExpanses: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        taxDeduction: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        interestPaid: ExpanseInformationInputModelItem(
            amount: TextEditingController(), comment: TextEditingController()),
        total: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> costInfoDataList = [];
    for (ExpanseInformationInputModel element
        in expanseInformationInputItemList) {
      final double total = double.parse(
              element.personalAndFoodingExpanses!.amount!.text.isEmpty
                  ? '0.0'
                  : element.personalAndFoodingExpanses!.amount!.text.trim()) +
          double.parse(element.houseExpanse!.amount!.text.isEmpty
              ? '0.0'
              : element.houseExpanse!.amount!.text.trim()) +
          double.parse(element.personalTransportExpanses!.amount!.text.isEmpty
              ? '0.0'
              : element.personalTransportExpanses!.amount!.text.trim()) +
          double.parse(element.utilityExpanses!.amount!.text.isEmpty
              ? '0.0'
              : element.utilityExpanses!.amount!.text.trim()) +
          double.parse(element.educationExpanses!.amount!.text.isEmpty
              ? '0.0'
              : element.educationExpanses!.amount!.text.trim()) +
          double.parse(element.personalExpanses!.amount!.text.isEmpty
              ? '0.0'
              : element.personalExpanses!.amount!.text.trim()) +
          double.parse(element.festivalExpanses!.amount!.text.isEmpty
              ? '0.0'
              : element.festivalExpanses!.amount!.text.trim()) +
          double.parse(element.taxDeduction!.amount!.text.isEmpty
              ? '0.0'
              : element.taxDeduction!.amount!.text.trim()) +
          double.parse(element.interestPaid!.amount!.text.isEmpty ? '0.0' : element.interestPaid!.amount!.text.trim());
      element.total!.text = '$total';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'personalAndFoodingExpanses': {
          'amount': element.personalAndFoodingExpanses!.amount!.text.trim(),
          'comment': element.personalAndFoodingExpanses!.comment!.text.trim(),
        },
        'houseExpanses': {
          'amount': element.houseExpanse!.amount!.text.trim(),
          'comment': element.houseExpanse!.comment!.text.trim(),
        },
        'personalTransportExpanses': {
          'amount': element.personalTransportExpanses!.amount!.text.trim(),
          'comment': element.personalTransportExpanses!.comment!.text.trim(),
        },
        'utilityExpanses': {
          'amount': element.utilityExpanses!.amount!.text.trim(),
          'comment': element.utilityExpanses!.comment!.text.trim(),
        },
        'educationExpanses': {
          'amount': element.educationExpanses!.amount!.text.trim(),
          'comment': element.educationExpanses!.comment!.text.trim(),
        },
        'personalExpanses': {
          'amount': element.personalExpanses!.amount!.text.trim(),
          'comment': element.personalExpanses!.comment!.text.trim(),
        },
        'festivalExpanses': {
          'amount': element.festivalExpanses!.amount!.text.trim(),
          'comment': element.festivalExpanses!.comment!.text.trim(),
        },
        'taxDeduction': {
          'amount': element.taxDeduction!.amount!.text.trim(),
          'comment': element.taxDeduction!.comment!.text.trim(),
        },
        'interestPaid': {
          'amount': element.interestPaid!.amount!.text.trim(),
          'comment': element.interestPaid!.comment!.text.trim(),
        },
        'total':  element.total!.text.trim(),
      };
      costInfoDataList.add(dataMap);
    }
    final Map<String, dynamic> costInfoDataMap = {'data': costInfoDataList};
    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.expanseInformation, data: costInfoDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
