import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/cost_info_input_model.dart';

class CostInformationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  bool deleteButtonOnTap=false;
  final GlobalKey<FormState> costInformationFormKey = GlobalKey();
  final TextEditingController nameOfAssesseeController =
      TextEditingController();
  final TextEditingController tinController = TextEditingController();

  List<CostInformationInputModel> costInformationInputItemList = [];

  void addCostInformationInputListItem() {
    if(costInformationFormKey.currentState!.validate()){
      costInformationInputItemList.add(CostInformationInputModel(
          personalAndFoodingExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          accommodationExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          personalTransportExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          utilityExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          educationExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          personalExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          festivalExpanses: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          taxDeduction: CostInformationInputModelItem(
              amount: TextEditingController(), comment: TextEditingController()),
          interestPaid: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController())));
      notifyListeners();
    }else{showToast('Fill the previous table first');}
  }

  void removeItemOfCostInformationInputList(int index) async{
    costInformationInputItemList.removeAt(index);
    await submitDataButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::

  Future<void> getCostInfoData() async {
    costInformationInputItemList = [];

    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.costInformation);

    if (data != null) {
      nameOfAssesseeController.text = data['nameOfAssessee'];
      tinController.text = data['tin'];

      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          costInformationInputItemList.add(
              CostInformationInputModel(
                  personalAndFoodingExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['personalAndFoodingExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['personalAndFoodingExpanses']['comment'])),
                  accommodationExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['accommodationExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['accommodationExpanses']['comment'])),
                  personalTransportExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['personalTransportExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['personalTransportExpanses']['comment'])),
                  utilityExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['utilityExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['utilityExpanses']['comment'])),
                  educationExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['educationExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['educationExpanses']['comment'])),
                  personalExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['personalExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['personalExpanses']['comment'])),
                  festivalExpanses: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['festivalExpanses']['amount']),
                      comment: TextEditingController(
                          text: element['festivalExpanses']['comment'])),
                  taxDeduction: CostInformationInputModelItem(
                      amount: TextEditingController(
                          text: element['taxDeduction']['amount']),
                      comment: TextEditingController(
                          text: element['taxDeduction']['comment'])),
                  interestPaid: CostInformationInputModelItem(
                      amount: TextEditingController(text: element['interestPaid']['amount']),
                      comment: TextEditingController(text: element['interestPaid']['comment']))));
        }
      }
    } else {
      costInformationInputItemList.add(CostInformationInputModel(
          personalAndFoodingExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          accommodationExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          personalTransportExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          utilityExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          educationExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          personalExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          festivalExpanses: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          taxDeduction: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController()),
          interestPaid: CostInformationInputModelItem(
              amount: TextEditingController(),
              comment: TextEditingController())));
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    if (!costInformationFormKey.currentState!.validate()) {
      return;
    }
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> costInfoDataList = [];
    for (CostInformationInputModel element in costInformationInputItemList) {
      final Map<String, dynamic> dataMap = {
        'personalAndFoodingExpanses': {
          'amount': element.personalAndFoodingExpanses!.amount!.text,
          'comment': element.personalAndFoodingExpanses!.comment!.text,
        },
        'accommodationExpanses': {
          'amount': element.accommodationExpanses!.amount!.text,
          'comment': element.accommodationExpanses!.comment!.text,
        },
        'personalTransportExpanses': {
          'amount': element.personalTransportExpanses!.amount!.text,
          'comment': element.personalTransportExpanses!.comment!.text,
        },
        'utilityExpanses': {
          'amount': element.utilityExpanses!.amount!.text,
          'comment': element.utilityExpanses!.comment!.text,
        },
        'educationExpanses': {
          'amount': element.educationExpanses!.amount!.text,
          'comment': element.educationExpanses!.comment!.text,
        },
        'personalExpanses': {
          'amount': element.personalExpanses!.amount!.text,
          'comment': element.personalExpanses!.comment!.text,
        },
        'festivalExpanses': {
          'amount': element.festivalExpanses!.amount!.text,
          'comment': element.festivalExpanses!.comment!.text,
        },
        'taxDeduction': {
          'amount': element.taxDeduction!.amount!.text,
          'comment': element.taxDeduction!.comment!.text,
        },
        'interestPaid': {
          'amount': element.interestPaid!.amount!.text,
          'comment': element.interestPaid!.comment!.text,
        },
      };
      costInfoDataList.add(dataMap);
    }
    final Map<String, dynamic> costInfoDataMap = {
      'nameOfAssessee': nameOfAssesseeController.text.trim(),
      'tin': tinController.text.trim(),
      'data': costInfoDataList
    };
    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.costInformation, data: costInfoDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
