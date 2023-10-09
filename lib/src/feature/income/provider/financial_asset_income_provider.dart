import 'package:flutter/Material.dart';
import '../model/financial_asset_income_input_model.dart';

class FinancialAssetIncomeProvider extends ChangeNotifier {
  bool loading = false;

  List<FDRIncomeItemModel?> fdrIncomeItemList = [
    FDRIncomeItemModel(
        fdrNo: TextEditingController(),
        investmentFigure: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController())
  ];

  List<DPSIncomeItemModel?> dpsIncomeItemList = [
    DPSIncomeItemModel(
        dpsNo: TextEditingController(),
        totalDepositAmount: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController())
  ];

  List<IncomeFromBankItemModel?> incomeFromBankItemList = [
    IncomeFromBankItemModel(
        bankAccountNo: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController())
  ];

  List<InsuranceProfitItemModel?> insuranceProfitItemList = [
    InsuranceProfitItemModel(
        insurancePolicyNo: TextEditingController(),
        premiumDeposit: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController())
  ];

  List<OthersProfitItemModel?> othersProfitItemList = [
    OthersProfitItemModel(
        investmentDetails: TextEditingController(),
        amountOfInvestment: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController())
  ];

  ///UI interaction functions::::::::::::::::::::::::::::::::::::::::::::::::::

  void addFdrIncomeListItem() {
    fdrIncomeItemList.add(FDRIncomeItemModel(
        fdrNo: TextEditingController(),
        investmentFigure: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }

  void removeFdrIncomeListItem(int index) {
    fdrIncomeItemList.removeAt(index);
    notifyListeners();
  }

  void addDpsIncomeListItem() {
    dpsIncomeItemList.add(DPSIncomeItemModel(
        dpsNo: TextEditingController(),
        totalDepositAmount: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }

  void removeDpsIncomeListItem(int index) {
    dpsIncomeItemList.removeAt(index);
    notifyListeners();
  }

  void addIncomeFromBankListItem() {
    incomeFromBankItemList.add(IncomeFromBankItemModel(
        bankAccountNo: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }

  void removeIncomeFromBankListItem(int index) {
    incomeFromBankItemList.removeAt(index);
    notifyListeners();
  }

  void addInsuranceProfitListItem() {
    insuranceProfitItemList.add(InsuranceProfitItemModel(
        insurancePolicyNo: TextEditingController(),
        premiumDeposit: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }

  void removeInsuranceProfitListItem(int index) {
    insuranceProfitItemList.removeAt(index);
    notifyListeners();
  }

  void addOthersProfitListItem() {
    othersProfitItemList.add(OthersProfitItemModel(
        investmentDetails: TextEditingController(),
        amountOfInvestment: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }

  void removeOthersProfitListItem(int index) {
    othersProfitItemList.removeAt(index);
    notifyListeners();
  }
}
