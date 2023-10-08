import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../model/cost_info_input_model.dart';

class CostInformationProvider extends ChangeNotifier {
  bool loading = false;
  final TextEditingController nameOfAddressController = TextEditingController();
  final TextEditingController tinController = TextEditingController();

  List<CostInformationInputModel> costInformationInputItemList = [
    CostInformationInputModel(
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
            amount: TextEditingController(), comment: TextEditingController()))
  ];

  void addCostInformationInputListItem() {
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
  }

  void removeItemOfCostInformationInputList(int index) {
    costInformationInputItemList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
