import 'package:flutter/Material.dart';

// class FinancialAssetIncomeInputModel{
//   FDRIncomeItemModel? fdrIncome;
//   DPSIncomeItemModel? dpsIncome;
//   IncomeFromBankItemModel? incomeFromBank;
//   InsuranceProfitItemModel? insuranceProfit;
//   OthersProfitItemModel? othersProfit;
//
//   FinancialAssetIncomeInputModel({this.fdrIncome, this.dpsIncome,
//       this.incomeFromBank, this.insuranceProfit, this.othersProfit});
// }

class FDRIncomeItemModel{
  TextEditingController? fdrNo;
  TextEditingController? investmentFigure;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;

  FDRIncomeItemModel({
      this.fdrNo, this.investmentFigure, this.profitReceived, this.sourceTax});
}

class DPSIncomeItemModel{
  TextEditingController? dpsNo;
  TextEditingController? totalDepositAmount;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;

  DPSIncomeItemModel({
      this.dpsNo, this.totalDepositAmount, this.profitReceived, this.sourceTax});
}

class IncomeFromBankItemModel{
  TextEditingController? bankAccountNo;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;

  IncomeFromBankItemModel({
      this.bankAccountNo, this.profitReceived, this.sourceTax});
}

class InsuranceProfitItemModel{
  TextEditingController? insurancePolicyNo;
  TextEditingController? premiumDeposit;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;

  InsuranceProfitItemModel({this.insurancePolicyNo, this.premiumDeposit,
      this.profitReceived, this.sourceTax});
}
class OthersProfitItemModel{
  TextEditingController? investmentDetails;
  TextEditingController? amountOfInvestment;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;

  OthersProfitItemModel({this.investmentDetails, this.amountOfInvestment,
      this.profitReceived, this.sourceTax});
}