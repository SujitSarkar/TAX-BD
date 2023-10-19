import 'package:flutter/Material.dart';

class PartnershipBusinessIncomeInputModel {
  final TextEditingController? nameOfBusiness;
  final TextEditingController? taxPaid;
  final TextEditingController? profit;
  final TextEditingController? salaryDiscountCommission;
  final TextEditingController? totalProfit;
  final TextEditingController? exemptedAmount;

  PartnershipBusinessIncomeInputModel(
      {this.nameOfBusiness, this.taxPaid,
      this.profit,
      this.salaryDiscountCommission,
      this.totalProfit,
      this.exemptedAmount});
}
