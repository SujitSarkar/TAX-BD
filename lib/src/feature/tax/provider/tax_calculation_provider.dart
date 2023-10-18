import 'package:flutter/material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/tax_calculation__input_model.dart';

class TaxCalculationProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<TaxCalculationInputModel> taxCalculationInputList = [];

  void clearAllData(){
    taxCalculationInputList=[];
  }

  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addTaxCalculationInputListItem() {
    taxCalculationInputList.add(
      TaxCalculationInputModel(
        grossTax: TextEditingController(),
        taxRebate: TextEditingController(),
        netTaxAfterRebate: TextEditingController(),
        minimumTax: TextEditingController(),
        taxPayable: TextEditingController(),
        netWealthSurcharge: TextEditingController(),
        environmentalSurcharge: TextEditingController(),
        delayInterest: TextEditingController(),
        totalAmountPayable: TextEditingController(),
        taxDeductedSource: TextEditingController(),
        advanceTaxPaid: TextEditingController(),
        adjustmentOfTax: TextEditingController(),
        taxPaidWithReturn: TextEditingController(),
        totalTaxPaid: TextEditingController(),
        excessPayment: TextEditingController(),
        taxExempted: TextEditingController(),
      ),
    );
    notifyListeners();
  }

  void removeItemOfTaxCalculationInputList(int index) async {
    taxCalculationInputList.removeAt(index);
    await submitDataButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> getTaxCalculationData() async {
    taxCalculationInputList = [];

    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.taxCalculation);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          taxCalculationInputList.add(
            TaxCalculationInputModel(
              grossTax: TextEditingController(text: element['grossTax']),
              taxRebate: TextEditingController(text: element['taxRebate']),
              netTaxAfterRebate: TextEditingController(text:element['netTaxAfterRebate']),
              minimumTax: TextEditingController(text: element['minimumTax']),
              taxPayable: TextEditingController(text: element['taxPayable']),
              netWealthSurcharge: TextEditingController(text: element['netWealthSurcharge']),
              environmentalSurcharge: TextEditingController(text: element['environmentalSurcharge']),
              delayInterest: TextEditingController(text: element['delayInterest']),
              totalAmountPayable: TextEditingController(text: element['totalAmountPayable']),
              taxDeductedSource: TextEditingController(text: element['taxDeductedSource']),
              advanceTaxPaid: TextEditingController(text: element['advanceTaxPaid']),
              adjustmentOfTax: TextEditingController(text:element['adjustmentOfTax']),
              taxPaidWithReturn: TextEditingController(text: element['taxPaidWithReturn']),
              totalTaxPaid: TextEditingController(text: element['totalTaxPaid']),
              excessPayment: TextEditingController(text: element['excessPayment']),
              taxExempted: TextEditingController(text: element['taxExempted']),
            ),
          );
        }
      }
    } else {
      taxCalculationInputList.add(
        TaxCalculationInputModel(
          grossTax: TextEditingController(),
          taxRebate: TextEditingController(),
          netTaxAfterRebate: TextEditingController(),
          minimumTax: TextEditingController(),
          taxPayable: TextEditingController(),
          netWealthSurcharge: TextEditingController(),
          environmentalSurcharge: TextEditingController(),
          delayInterest: TextEditingController(),
          totalAmountPayable: TextEditingController(),
          taxDeductedSource: TextEditingController(),
          advanceTaxPaid: TextEditingController(),
          adjustmentOfTax: TextEditingController(),
          taxPaidWithReturn: TextEditingController(),
          totalTaxPaid: TextEditingController(),
          excessPayment: TextEditingController(),
          taxExempted: TextEditingController(),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> taxCalculationDataList = [];
    for (TaxCalculationInputModel element in taxCalculationInputList) {

      final double netTaxAfterRebateValue = double.parse(
              element.grossTax!.text.isEmpty
                  ? '0.0'
                  : element.grossTax!.text.trim()) -
          double.parse(element.taxRebate!.text.isEmpty
              ? '0.0'
              : element.taxRebate!.text.trim());

      final double totalAmountPayableValue = double.parse(
              element.taxPayable!.text.isEmpty
                  ? '0.0'
                  : element.taxPayable!.text.trim()) +
          double.parse(element.netWealthSurcharge!.text.isEmpty
              ? '0.0'
              : element.netWealthSurcharge!.text.trim()) +
          double.parse(element.environmentalSurcharge!.text.isEmpty
              ? '0.0'
              : element.environmentalSurcharge!.text.trim());

      final double totalTaxPaidValue = totalAmountPayableValue +
          double.parse(element.taxDeductedSource!.text.isEmpty
              ? '0.0'
              : element.taxDeductedSource!.text.trim()) +
          double.parse(element.advanceTaxPaid!.text.isEmpty
              ? '0.0'
              : element.advanceTaxPaid!.text.trim()) +
          double.parse(element.adjustmentOfTax!.text.isEmpty
              ? '0.0'
              : element.adjustmentOfTax!.text.trim());

      final double excessPaymentValue =
          double.parse(element.taxPaidWithReturn!.text.isEmpty
              ? '0.0'
              : element.taxPaidWithReturn!.text.trim()) -
          double.parse(element.delayInterest!.text.isEmpty
              ? '0.0'
              : element.delayInterest!.text.trim());

      element.netTaxAfterRebate!.text = '$netTaxAfterRebateValue';
      element.totalAmountPayable!.text = '$totalAmountPayableValue';
      element.totalTaxPaid!.text = '$totalTaxPaidValue';
      element.excessPayment!.text = '$excessPaymentValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'grossTax': element.grossTax!.text,
        'taxRebate': element.taxRebate!.text,
        'netTaxAfterRebate': element.netTaxAfterRebate!.text,
        'minimumTax': element.minimumTax!.text,
        'taxPayable': element.taxPayable!.text,
        'netWealthSurcharge': element.netWealthSurcharge!.text,
        'environmentalSurcharge': element.environmentalSurcharge!.text,
        'delayInterest': element.delayInterest!.text,
        'totalAmountPayable': element.totalAmountPayable!.text,
        'taxDeductedSource': element.taxDeductedSource!.text,
        'advanceTaxPaid': element.advanceTaxPaid!.text,
        'adjustmentOfTax': element.adjustmentOfTax!.text,
        'taxPaidWithReturn': element.taxPaidWithReturn!.text,
        'totalTaxPaid': element.totalTaxPaid!.text,
        'excessPayment': element.excessPayment!.text,
        'taxExempted': element.taxExempted!.text,
      };
      taxCalculationDataList.add(dataMap);
    }
    final Map<String, dynamic> taxCalculationDataMap = {'data': taxCalculationDataList};

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.taxCalculation, data: taxCalculationDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
