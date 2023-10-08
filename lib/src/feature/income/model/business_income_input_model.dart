import 'package:flutter/material.dart';

class BusinessIncomeInputModel {
  TextEditingController? saleTurnoverReceipts;
  TextEditingController? grossProfit;
  TextEditingController? generalExpanses;
  TextEditingController? badDebtExpanses;
  TextEditingController? netProfit;
  TextEditingController? cashAndBankBalance;
  TextEditingController? inventory;
  TextEditingController? fixedAssets;
  TextEditingController? otherAssets;
  TextEditingController? totalAssets;
  TextEditingController? openingCapital;
  TextEditingController? balanceSheetNetProfit;
  TextEditingController? drawingDuringIncomeYear;
  TextEditingController? closingCapital;
  TextEditingController? liabilities;
  TextEditingController? totalCapitalAndLiabilities;

  BusinessIncomeInputModel({
      this.saleTurnoverReceipts,
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
      this.totalCapitalAndLiabilities});
}
