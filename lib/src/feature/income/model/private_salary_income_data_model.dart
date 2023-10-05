import 'package:flutter/material.dart';

class PrivateSalaryIncomeInputModel {
  TextEditingController? basicPay;
  TextEditingController? allowence;
  TextEditingController? advanceSalary;
  TextEditingController? benefits;
  TextEditingController? perquisites;
  TextEditingController? additionalSalaryOrWages;
  TextEditingController? shareSceme;
  TextEditingController? accomodationBenefits;
  TextEditingController? carBenefits;
  TextEditingController? anyOtherBenefits;
  TextEditingController? providendFund;
  TextEditingController? others;
  TextEditingController? totalSalaryIncome;
  TextEditingController? exemptedSalary;
  TextEditingController? totalIncomeFromSalary;

  PrivateSalaryIncomeInputModel(
      {this.basicPay,
      this.allowence,
      this.advanceSalary,
      this.benefits,
      this.perquisites,
      this.additionalSalaryOrWages,
      this.shareSceme,
      this.accomodationBenefits,
      this.carBenefits,
      this.anyOtherBenefits,
      this.providendFund,
      this.others,
      this.totalSalaryIncome,
      this.exemptedSalary,
      this.totalIncomeFromSalary});
}
