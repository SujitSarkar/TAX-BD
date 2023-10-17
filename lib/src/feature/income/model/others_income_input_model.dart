import 'package:flutter/Material.dart';

class OthersIncomeInputModel{
  final TextEditingController? particular;
  final TextEditingController? tdsDeducted;
  final TextEditingController? description;
  final TextEditingController? exemptedAmount;

  OthersIncomeInputModel({this.particular, this.tdsDeducted, this.description,this.exemptedAmount});
}