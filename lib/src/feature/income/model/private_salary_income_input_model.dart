import 'package:flutter/material.dart';

class PrivateSalaryIncomeInputModel {
  TextEditingController? basicPay;
  TextEditingController? allowance;
  TextEditingController? advanceSalary;
  TextEditingController? gratuityAnnuity;
  TextEditingController? perquisites;
  TextEditingController? additionalSalaryOrWages;
  TextEditingController? shareScheme;
  TextEditingController? accommodationFacility;
  TextEditingController? transportFacility;
  TextEditingController? anyOtherFacility;
  TextEditingController? providentFund;
  TextEditingController? others;
  TextEditingController? totalSalaryReceived;
  TextEditingController? exemptedAmount;
  TextEditingController? totalIncomeFromSalary;

  PrivateSalaryIncomeInputModel(
      {this.basicPay,
      this.allowance,
      this.advanceSalary,
      this.gratuityAnnuity,
      this.perquisites,
      this.additionalSalaryOrWages,
      this.shareScheme,
      this.accommodationFacility,
      this.transportFacility,
      this.anyOtherFacility,
      this.providentFund,
      this.others,
      this.totalSalaryReceived,
      this.exemptedAmount,
      this.totalIncomeFromSalary});
}
