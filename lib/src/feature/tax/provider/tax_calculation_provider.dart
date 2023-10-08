import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../model/tax_calculation__input_model.dart';

class TaxCalculationProvider extends ChangeNotifier {
  bool loading = false;

  List<TaxCalculationInputModel> taxCalculationInputList = [
    TaxCalculationInputModel(
        grossTax: TextEditingController(),
        taxRebate: TextEditingController(),
        taxPayableAfterTaxRebate: TextEditingController(),
        minimumTax: TextEditingController(),
        taxPayable: TextEditingController(),
        surchargeOfNetWealth: TextEditingController(),
        surchargeOfEnvironmental: TextEditingController(),
        delayInterest: TextEditingController(),
        totalTaxPayable: TextEditingController(),
        taxDeducted: TextEditingController(),
        advanceTax: TextEditingController(),
        adjustmentOfTax: TextEditingController(),
        amountPaidWithReturn: TextEditingController(),
        totalTaxPaid: TextEditingController(),
        deficitOrExcess: TextEditingController())
  ];

  void addTaxCalculationInputListItem() {
    taxCalculationInputList.add(TaxCalculationInputModel(
        grossTax: TextEditingController(),
        taxRebate: TextEditingController(),
        taxPayableAfterTaxRebate: TextEditingController(),
        minimumTax: TextEditingController(),
        taxPayable: TextEditingController(),
        surchargeOfNetWealth: TextEditingController(),
        surchargeOfEnvironmental: TextEditingController(),
        delayInterest: TextEditingController(),
        totalTaxPayable: TextEditingController(),
        taxDeducted: TextEditingController(),
        advanceTax: TextEditingController(),
        adjustmentOfTax: TextEditingController(),
        amountPaidWithReturn: TextEditingController(),
        totalTaxPaid: TextEditingController(),
        deficitOrExcess: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfRebateCalculationInputList(int index) {
    taxCalculationInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
