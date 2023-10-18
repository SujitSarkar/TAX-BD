import 'package:flutter/Material.dart';

class OthersIncomeInputModel{
  final ParticularInputModel? particular;
  final TextEditingController? tdsDeducted;
  final TextEditingController? exemptedAmount;

  OthersIncomeInputModel({this.particular, this.tdsDeducted, this.exemptedAmount});
}

class ParticularInputModel{
  final TextEditingController? description;
  final TextEditingController? amount;

  ParticularInputModel({this.description, this.amount});
}