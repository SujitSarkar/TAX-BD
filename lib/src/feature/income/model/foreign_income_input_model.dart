import 'package:flutter/cupertino.dart';
import 'others_income_input_model.dart';

class ForeignIncomeInputModel{
  final ParticularInputModel? particular;
  final TextEditingController? exemptedAmount;
  bool throughBankingChannel;

  ForeignIncomeInputModel({this.particular, required this.throughBankingChannel,this.exemptedAmount});
}