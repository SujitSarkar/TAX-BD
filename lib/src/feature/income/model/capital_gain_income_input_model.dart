import 'package:flutter/Material.dart';

class CapitalGainIncomeInputModel {
  String? typeOfGains;
  final TextEditingController? description;
  final TextEditingController? area;
  String? areaUnit;
  final TextEditingController? tinOfBuyer;
  final TextEditingController? deedNo;
  DateTime? dateOfDeed;
  final TextEditingController? dateOfDeedText;
  final TextEditingController? subRegistrarOffice;
  final TextEditingController? saleDeedValue;
  final TextEditingController? costOfAcquisition;
  final TextEditingController? capitalGain;
  final TextEditingController? taxDeductedCollectedAtSource;
  ///House/Apartment
  final TextEditingController? flatBuildingArea;
  String? flatBuildingUnit;
  ///Other Capital Gain
  DateTime? acquisitionDate;
  final TextEditingController? acquisitionDateText;
  DateTime? salesDate;
  final TextEditingController? salesDateText;
  final TextEditingController? salesValue;
  final TextEditingController? costOfSales;

  CapitalGainIncomeInputModel({
    this.typeOfGains,
    this.description,
    this.area,
    this.areaUnit,
    this.tinOfBuyer,
    this.deedNo,
    this.dateOfDeed,
    this.dateOfDeedText,
    this.subRegistrarOffice,
    this.saleDeedValue,
    this.costOfAcquisition,
    this.capitalGain,
    this.taxDeductedCollectedAtSource,
    this.flatBuildingArea,
    this.flatBuildingUnit,
    this.acquisitionDate,
    this.acquisitionDateText,
    this.salesDate,
    this.salesDateText,
    this.salesValue,
    this.costOfSales,
  });
}
