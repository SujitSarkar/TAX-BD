import 'package:flutter/material.dart';

class AssetInfoInputModel {
  //Source of found
  final TextEditingController? sofTotalIncome;
  final TextEditingController? sofTaxExemptedIncome;
  final TextEditingController? sofReceiptOfGift;
  final TextEditingController? totalSourceOfFund;

  final TextEditingController? netWealthOfPreviousIncomeYear;
  final TextEditingController? sumOfSourceOfFound;

  final TextEditingController? expenseOfLifestyle;
  final TextEditingController? giftExpanseLoss;
  final TextEditingController? totalExpanseAndLoss;

  final TextEditingController? netWealthLastDateOfFinancialYear;

  //Personal liabilities Outside BD
  final TextEditingController? plobInstLiabilities;
  final TextEditingController? plobNonInstLiabilities;
  final TextEditingController? plobOtherLiabilities;
  final TextEditingController? totalLiabilitiesOutsideBd;

  final TextEditingController? grossWealth;

  ///Particulars of Assets
  final TextEditingController? totalAssetOfBusiness;
  final TextEditingController? lessBusinessLiabilities;
  final TextEditingController? directorShareholdings;
  final TextEditingController? businessCapitalOfPartnershipFirm;
  final TextEditingController? nonAgriculturalProperty;
  final TextEditingController? agriculturalProperty;

  //Financial Assets
  final TextEditingController? shareDebentureBondSecurities;
  final TextEditingController? sanchaypatraDepositPensionScheme;
  final TextEditingController? loanGiven;
  final TextEditingController? savingsDeposit;
  final TextEditingController? providentOrOtherFund;
  final TextEditingController? otherInvestment;
  final TextEditingController? totalFinancialAssets;

  final TextEditingController? motorVehicle;
  final TextEditingController? ornaments;
  final TextEditingController? furnitureAndElectronicItems;
  final TextEditingController? otherAsset;

  //Cash in Hand and Fund Outside Business
  final TextEditingController? bankBalance;
  final TextEditingController? cashInHand;
  final TextEditingController? othersOfCashInHand;
  final TextEditingController? totalCashInHand;

  final TextEditingController? assetOutsideBd;
  final TextEditingController? totalAssetsInBdOutsideBd;

  AssetInfoInputModel({
      this.sofTotalIncome,
      this.sofTaxExemptedIncome,
      this.sofReceiptOfGift,
      this.totalSourceOfFund,
      this.netWealthOfPreviousIncomeYear,
      this.sumOfSourceOfFound,
      this.expenseOfLifestyle,
      this.giftExpanseLoss,
      this.totalExpanseAndLoss,
      this.netWealthLastDateOfFinancialYear,
      this.plobInstLiabilities,
      this.plobNonInstLiabilities,
      this.plobOtherLiabilities,
      this.totalLiabilitiesOutsideBd,
      this.grossWealth,
      this.totalAssetOfBusiness,
      this.lessBusinessLiabilities,
      this.directorShareholdings,
      this.businessCapitalOfPartnershipFirm,
      this.nonAgriculturalProperty,
      this.agriculturalProperty,
      this.shareDebentureBondSecurities,
      this.sanchaypatraDepositPensionScheme,
      this.loanGiven,
      this.savingsDeposit,
      this.providentOrOtherFund,
      this.otherInvestment,
      this.totalFinancialAssets,
      this.motorVehicle,
      this.ornaments,
      this.furnitureAndElectronicItems,
      this.otherAsset,
      this.bankBalance,
      this.cashInHand,
      this.othersOfCashInHand,
      this.totalCashInHand,
      this.assetOutsideBd,
      this.totalAssetsInBdOutsideBd});
}