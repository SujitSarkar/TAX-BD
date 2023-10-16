import 'package:flutter/Material.dart';

class CapitalGainIncomeInputModel{
  final TextEditingController? particular;
  DateTime? acquisitionDateTime;
  final TextEditingController? acquisitionDateText;
  DateTime? salesDateTime;
  final TextEditingController? salesDateText;
  final TextEditingController? acquisitionValue;
  final TextEditingController? sales;
  final TextEditingController? salesCost;
  final TextEditingController? gain;

  CapitalGainIncomeInputModel({
      this.particular,
      this.acquisitionDateTime,
      this.acquisitionDateText,
      this.salesDateTime,
      this.salesDateText,
      this.acquisitionValue,
      this.sales,
      this.salesCost,
      this.gain});
}