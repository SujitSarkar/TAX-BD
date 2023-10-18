import 'package:flutter/cupertino.dart';

import 'others_income_input_model.dart';

class PartnershipBusinessIncomeInputModel {
  final ParticularInputModel? particular;
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
