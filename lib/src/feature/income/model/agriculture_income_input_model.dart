import 'package:flutter/material.dart';

class AgricultureIncomeInputModel {
  TextEditingController? saleTurnoverReceipts;
  TextEditingController? grossProfit;
  TextEditingController? generalExpanses;
  TextEditingController? netProfit;

  AgricultureIncomeInputModel(
      {this.saleTurnoverReceipts,
      this.grossProfit,
      this.generalExpanses,
      this.netProfit});
}
