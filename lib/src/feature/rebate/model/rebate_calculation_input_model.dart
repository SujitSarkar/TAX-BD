import 'package:flutter/material.dart';

class RebateCalculationInputModel {
  TextEditingController? lifeInsurance;
  TextEditingController? contributionToDepositPerson;
  TextEditingController? investmentInGovt;
  TextEditingController? investmentInSecurity;
  TextEditingController? contributionToProvident;
  TextEditingController? selfContribution;
  TextEditingController? contributionToApproved;
  TextEditingController? contributionToBenevolent;
  TextEditingController? contributionToZakat;
  TextEditingController? others;
  TextEditingController? totalInvestment;
  TextEditingController? amountOfTax;

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
