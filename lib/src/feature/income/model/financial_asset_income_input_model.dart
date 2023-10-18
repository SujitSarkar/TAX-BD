import 'package:flutter/Material.dart';

class FDRIncomeItemModel{
  TextEditingController? fdrNo;
  TextEditingController? investmentFigure;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;
  TextEditingController? total;

  FDRIncomeItemModel({
      this.fdrNo, this.investmentFigure, this.profitReceived, this.sourceTax,this.total});
}

class DPSIncomeItemModel{
  TextEditingController? dpsNo;
  TextEditingController? totalDepositAmount;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;
  TextEditingController? total;

  DPSIncomeItemModel({
      this.dpsNo, this.totalDepositAmount, this.profitReceived, this.sourceTax,this.total});
}

class IncomeFromBankItemModel{
  TextEditingController? bankAccountNo;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;
  TextEditingController? total;

  IncomeFromBankItemModel({
      this.bankAccountNo, this.profitReceived, this.sourceTax,this.total});
}

class InsuranceProfitItemModel{
  TextEditingController? insurancePolicyNo;
  TextEditingController? premiumDeposit;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;
  TextEditingController? total;

  InsuranceProfitItemModel({this.insurancePolicyNo, this.premiumDeposit,
      this.profitReceived, this.sourceTax,this.total});
}
class OthersProfitItemModel{
  TextEditingController? investmentDetails;
  TextEditingController? amountOfInvestment;
  TextEditingController? profitReceived;
  TextEditingController? sourceTax;
  TextEditingController? exemptedAmount;
  TextEditingController? total;

  OthersProfitItemModel({this.investmentDetails, this.amountOfInvestment,
      this.profitReceived, this.sourceTax, this.exemptedAmount,this.total});
}