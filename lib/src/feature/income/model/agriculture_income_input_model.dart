import 'package:flutter/material.dart';

class AgricultureIncomeInputModel {
  final TextEditingController? saleTurnoverReceipt;
  final TextEditingController? grossProfit;
  final TextEditingController? generalExpanses;
  final TextEditingController? netProfit;
  final TextEditingController? exemptedAmount;

  AgricultureIncomeInputModel(
      {this.saleTurnoverReceipt,
      this.grossProfit,
      this.generalExpanses,
      this.netProfit,
      this.exemptedAmount});
}
