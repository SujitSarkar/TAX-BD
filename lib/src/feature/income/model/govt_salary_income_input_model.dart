import 'package:flutter/material.dart';

class GovtSalaryIncomeInputModel {
  GovtSalaryIncomeInputModelItem? basicPay;
  GovtSalaryIncomeInputModelItem? arrearPay;
  GovtSalaryIncomeInputModelItem? specialAllowance;
  GovtSalaryIncomeInputModelItem? houseRentAllowance;
  GovtSalaryIncomeInputModelItem? medicalAllowance;
  GovtSalaryIncomeInputModelItem? conveyanceAllowance;
  GovtSalaryIncomeInputModelItem? festivalAllowance;
  GovtSalaryIncomeInputModelItem? supportStaffAllowance;
  GovtSalaryIncomeInputModelItem? leaveAllowance;
  GovtSalaryIncomeInputModelItem? honorariumReward;
  GovtSalaryIncomeInputModelItem? overtimeAllowances ;
  GovtSalaryIncomeInputModelItem? banglaNoboborshoAllowances;
  GovtSalaryIncomeInputModelItem? interestAccruedOnProvidentFund;
  GovtSalaryIncomeInputModelItem? lumpGrant;
  GovtSalaryIncomeInputModelItem? gratuity;
  GovtSalaryIncomeInputModelItem? others;
  GovtSalaryIncomeInputModelItem? total;

  GovtSalaryIncomeInputModel({
      this.basicPay,
      this.arrearPay,
      this.specialAllowance,
      this.houseRentAllowance,
      this.medicalAllowance,
      this.conveyanceAllowance,
      this.festivalAllowance,
      this.supportStaffAllowance,
      this.leaveAllowance,
      this.honorariumReward,
      this.overtimeAllowances,
      this.banglaNoboborshoAllowances,
      this.interestAccruedOnProvidentFund,
      this.lumpGrant,
      this.gratuity,
      this.others,
      this.total});
}

class GovtSalaryIncomeInputModelItem{
  TextEditingController? amount;
  TextEditingController? exempted;
  TextEditingController? taxable;

  GovtSalaryIncomeInputModelItem({this.amount, this.exempted, this.taxable});
}