import 'package:flutter/material.dart';

class PrivateSalaryIncomeInputModel {
  TextEditingController? basicPay;
  TextEditingController? allowance;
  TextEditingController? advanceSalary;
  TextEditingController? benefits;
  TextEditingController? perquisites;
  TextEditingController? additionalSalaryOrWages;
  TextEditingController? shareScheme;
  TextEditingController? accommodationBenefits;
  TextEditingController? carBenefits;
  TextEditingController? anyOtherBenefits;
  TextEditingController? providentFund;
  TextEditingController? others;
  TextEditingController? totalSalaryIncome;
  TextEditingController? exemptedSalary;
  TextEditingController? totalIncomeFromSalary;

  PrivateSalaryIncomeInputModel(
      {this.basicPay,
      this.allowance,
      this.advanceSalary,
      this.benefits,
      this.perquisites,
      this.additionalSalaryOrWages,
      this.shareScheme,
      this.accommodationBenefits,
      this.carBenefits,
      this.anyOtherBenefits,
      this.providentFund,
      this.others,
      this.totalSalaryIncome,
      this.exemptedSalary,
      this.totalIncomeFromSalary});
}
