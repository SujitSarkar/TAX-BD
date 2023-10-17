import 'package:flutter/cupertino.dart';

class PartnershipBusinessIncomeInputModel {
  final TextEditingController? particular;
  final TextEditingController? taxPaid;
  final TextEditingController? profit;
  final TextEditingController? salaryDiscountCommission;
  final TextEditingController? totalProfit;
  final TextEditingController? exemptedAmount;

  PartnershipBusinessIncomeInputModel(
      {this.particular,
      this.taxPaid,
      this.profit,
      this.salaryDiscountCommission,
      this.totalProfit,
      this.exemptedAmount});
}
