import 'package:flutter/material.dart';

class RentalIncomeInputModel {
  TextEditingController? locationAndDescription;
  TextEditingController? rentReceipt;
  TextEditingController? advanceRentReceipt;
  TextEditingController? valueOfAnyBenefits;
  TextEditingController? adjustedAdvanceRent;
  TextEditingController? vacancyAllowance;
  TextEditingController? totalRentIncome;
  TextEditingController? repairAD; //AD = Allowance Deduction
  TextEditingController? municipalAD;
  TextEditingController? landAD;
  TextEditingController? interestAD;
  TextEditingController? insuranceAD;
  TextEditingController? otherAD;
  TextEditingController? totalAdmissibleDeduction;
  TextEditingController? incomeFromHouseProperty;
  TextEditingController? inCaseOfPartial;

  RentalIncomeInputModel({
      this.locationAndDescription,
      this.rentReceipt,
      this.advanceRentReceipt,
      this.valueOfAnyBenefits,
      this.adjustedAdvanceRent,
      this.vacancyAllowance,
      this.totalRentIncome,
      this.repairAD,
      this.municipalAD,
      this.landAD,
      this.interestAD,
      this.insuranceAD,
      this.otherAD,
      this.totalAdmissibleDeduction,
      this.incomeFromHouseProperty,
      this.inCaseOfPartial});
}
