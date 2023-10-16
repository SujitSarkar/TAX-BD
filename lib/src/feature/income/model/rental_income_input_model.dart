import 'package:flutter/material.dart';

class RentalIncomeInputModel {
  final TextEditingController? locationAndDescription;
  final TextEditingController? rentReceived;
  final TextEditingController? advanceRentReceived;
  final TextEditingController? valueOfAnyBenefits;
  final TextEditingController? adjustedAdvanceRent;
  final TextEditingController? vacancyAllowance;
  final TextEditingController? totalRentIncome;
  final TextEditingController? repairAD; //AD = Allowable Deduction
  final TextEditingController? municipalAD;
  final TextEditingController? landAD;
  final TextEditingController? interestAD;
  final TextEditingController? insuranceAD;
  final TextEditingController? otherAD;
  final TextEditingController? totalAdmissibleDeduction;
  final TextEditingController? netIncome;
  final TextEditingController? taxpayerShare;

  RentalIncomeInputModel({
      this.locationAndDescription,
      this.rentReceived,
      this.advanceRentReceived,
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
      this.netIncome,
      this.taxpayerShare});
}
