import 'package:flutter/material.dart';

class GovtSalaryIncomeInputModel {
  TextEditingController? basicPay;
  TextEditingController? arrearPay;
  TextEditingController? specialAllowance;
  TextEditingController? houseRentAllowance;
  TextEditingController? medicalAllowance;
  TextEditingController? conveyanceAllowance;
  TextEditingController? festivalAllowance;
  TextEditingController? supportStaffAllowance;
  TextEditingController? leaveAllowance;
  TextEditingController? honorariumReward;
  TextEditingController? overtimeAllowances ;
  TextEditingController? banglaNoboborshoAllowances;
  TextEditingController? interestAccruedOnProvidentFund;
  TextEditingController? lumpGrant;
  TextEditingController? gratuity;
  TextEditingController? others;
  TextEditingController? total;

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