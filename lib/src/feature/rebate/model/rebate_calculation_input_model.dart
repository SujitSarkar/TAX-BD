import 'package:flutter/material.dart';

class RebateCalculationInputModel {
  final TextEditingController? lifeInsurance;
  final TextEditingController? contributionToDepositPerson;
  final TextEditingController? investmentInGovt;
  final TextEditingController? investmentInSecurity;
  final TextEditingController? contributionToProvident;
  final TextEditingController? selfContribution;
  final TextEditingController? contributionToApproved;
  final TextEditingController? contributionToBenevolent;
  final TextEditingController? contributionToZakat;
  final TextEditingController? others;
  final TextEditingController? totalInvestment;
  final TextEditingController? amountOfTax;

  RebateCalculationInputModel({
      this.lifeInsurance,
      this.contributionToDepositPerson,
      this.investmentInGovt,
      this.investmentInSecurity,
      this.contributionToProvident,
      this.selfContribution,
      this.contributionToApproved,
      this.contributionToBenevolent,
      this.contributionToZakat,
      this.others,
      this.totalInvestment,
      this.amountOfTax});
}
