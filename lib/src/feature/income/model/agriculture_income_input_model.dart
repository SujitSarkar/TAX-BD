import 'package:flutter/material.dart';

class AgricultureIncomeInputModel {
  final TextEditingController? saleTurnoverReceipt;
  final TextEditingController? grossProfit;
  final TextEditingController? generalExpanses;
  final TextEditingController? netProfit;

  AgricultureIncomeInputModel(
      {this.saleTurnoverReceipt,
      this.grossProfit,
      this.generalExpanses,
      this.netProfit});
}
