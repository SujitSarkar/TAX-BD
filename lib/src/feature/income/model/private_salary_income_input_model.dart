import 'package:flutter/material.dart';

class PrivateSalaryIncomeInputModel {
  final TextEditingController? nameOfEmployer;
  final TextEditingController? employerDesignation;
  final TextEditingController? basicSalary;
  final TextEditingController? houseRentAllowance;
  final TextEditingController? medicalAllowance;
  final TextEditingController? conveyanceAllowance;
  final TextEditingController? festivalBonus;
  final TextEditingController? others;
  final TextEditingController? totalIncomeFromSalary;
  final TextEditingController? exempted;
  bool? rentFreeAccommodation;
  final TextEditingController? rentFreeAccommodationValue;
  final TextEditingController? rentFreeAccommodationMonth;
  bool? accommodationAtConcessionalRate;
  final TextEditingController? concessionalRateValue;
  final TextEditingController? concessionalRateMonth;
  final TextEditingController? rentPaidByTaxpayer;
  bool? vehicleFacilityProvided;
  String? vehicleCC;
  final TextEditingController? vehicleFacilityMonth;
  bool? hasOtherNonCashBenefit;
  final OtherInputModel? otherNonCashBenefit;

  PrivateSalaryIncomeInputModel({
      this.nameOfEmployer,
      this.employerDesignation,
      this.basicSalary,
      this.houseRentAllowance,
      this.medicalAllowance,
      this.conveyanceAllowance,
      this.festivalBonus,
      this.others,
      this.totalIncomeFromSalary,
      this.exempted,
      this.rentFreeAccommodation=false,
      this.rentFreeAccommodationValue,
      this.rentFreeAccommodationMonth,
      this.accommodationAtConcessionalRate=false,
      this.concessionalRateValue,
      this.concessionalRateMonth,
      this.rentPaidByTaxpayer,
      this.vehicleFacilityProvided=false,
      this.vehicleCC,
      this.vehicleFacilityMonth,
      this.hasOtherNonCashBenefit=false,
      this.otherNonCashBenefit});
}

class OtherInputModel{
  final TextEditingController? particular;
  final TextEditingController? value;

  OtherInputModel({this.particular, this.value});
}
