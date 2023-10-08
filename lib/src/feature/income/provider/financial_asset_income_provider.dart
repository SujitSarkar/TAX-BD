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
}
