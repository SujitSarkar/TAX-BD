import 'package:flutter/Material.dart';
import 'others_income_input_model.dart';

class CapitalGainIncomeInputModel{
  final ParticularInputModel? particular;
  DateTime? acquisitionDateTime;
  final TextEditingController? acquisitionDateText;
  DateTime? salesDateTime;
  final TextEditingController? salesDateText;
  final TextEditingController? acquisitionValue;
  final TextEditingController? salesCost;
  final TextEditingController? gain;

  CapitalGainIncomeInputModel({
      this.particular,
      this.acquisitionDateTime,
      this.acquisitionDateText,
      this.salesDateTime,
      this.salesDateText,
      this.acquisitionValue,
      this.salesCost,
      this.gain});
}