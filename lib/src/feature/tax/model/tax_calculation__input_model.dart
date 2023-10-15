import 'package:flutter/material.dart';

class TaxCalculationInputModel {
  TextEditingController? grossTax;
  TextEditingController? taxRebate;
  TextEditingController? netTaxAfterRebate;
  TextEditingController? minimumTax;
  TextEditingController? taxPayable;
  TextEditingController? netWealthSurcharge;
  TextEditingController? environmentalSurcharge;
  TextEditingController? delayInterest;
  TextEditingController? totalAmountPayable;
  TextEditingController? taxDeductedSource;
  TextEditingController? advanceTaxPaid;
  TextEditingController? adjustmentOfTax;
  TextEditingController? taxPaidWithReturn;
  TextEditingController? totalTaxPaid;
  TextEditingController? excessPayment;
  TextEditingController? taxExempted;

  TaxCalculationInputModel(
      {this.grossTax,
      this.taxRebate,
      this.netTaxAfterRebate,
      this.minimumTax,
      this.taxPayable,
      this.netWealthSurcharge,
      this.environmentalSurcharge,
      this.delayInterest,
      this.totalAmountPayable,
      this.taxDeductedSource,
      this.advanceTaxPaid,
      this.adjustmentOfTax,
      this.taxPaidWithReturn,
      this.totalTaxPaid,
      this.excessPayment,
      this.taxExempted});
}
