import 'package:flutter/material.dart';

class TaxCalculationInputModel {
  TextEditingController? grossTax;
  TextEditingController? taxRebate;
  TextEditingController? taxPayableAfterTaxRebate;
  TextEditingController? minimumTax;
  TextEditingController? taxPayable;
  TextEditingController? surchargeOfNetWealth;
  TextEditingController? surchargeOfEnvironmental;
  TextEditingController? delayInterest;
  TextEditingController? totalTaxPayable;
  TextEditingController? taxDeducted;
  TextEditingController? advanceTax;
  TextEditingController? adjustmentOfTax;
  TextEditingController? amountPaidWithReturn;
  TextEditingController? totalTaxPaid;
  TextEditingController? deficitOrExcess;

  TaxCalculationInputModel({
      this.grossTax,
      this.taxRebate,
      this.taxPayableAfterTaxRebate,
      this.minimumTax,
      this.taxPayable,
      this.surchargeOfNetWealth,
      this.surchargeOfEnvironmental,
      this.delayInterest,
      this.totalTaxPayable,
      this.taxDeducted,
      this.advanceTax,
      this.adjustmentOfTax,
      this.amountPaidWithReturn,
      this.totalTaxPaid,
      this.deficitOrExcess});
}
