import 'package:flutter/material.dart';

class BusinessIncomeInputModel {
  final TextEditingController? nameOfBusiness;
  final TextEditingController? natureOfBusiness;
  final TextEditingController? addressOfBusiness;
  final TextEditingController? saleTurnoverReceipt;
  final TextEditingController? grossProfit;
  final TextEditingController? generalExpanses;
  final TextEditingController? badDebtExpanses;
  final TextEditingController? netProfit;
  final TextEditingController? exemptedAmount;
  final TextEditingController? cashAndBankBalance;
  final TextEditingController? inventory;
  final TextEditingController? fixedAssets;
  final TextEditingController? otherAssets;
  final TextEditingController? totalAssets;
  final TextEditingController? openingCapital;
  final TextEditingController? balanceSheetNetProfit;
  final TextEditingController? drawingDuringIncomeYear;
  final TextEditingController? closingCapital;
  final TextEditingController? liabilities;
  final TextEditingController? totalCapitalAndLiabilities;

  BusinessIncomeInputModel(
      {this.nameOfBusiness,
      this.natureOfBusiness,
      this.addressOfBusiness,
      this.saleTurnoverReceipt,
      this.grossProfit,
      this.generalExpanses,
      this.badDebtExpanses,
      this.netProfit,
      this.cashAndBankBalance,
      this.inventory,
      this.fixedAssets,
      this.otherAssets,
      this.totalAssets,
      this.openingCapital,
      this.balanceSheetNetProfit,
      this.drawingDuringIncomeYear,
      this.closingCapital,
      this.liabilities,
      this.totalCapitalAndLiabilities,
      this.exemptedAmount});
}
