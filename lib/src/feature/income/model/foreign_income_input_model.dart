import 'package:flutter/cupertino.dart';

class ForeignIncomeInputModel{
  final TextEditingController? particular;
  final TextEditingController? exemptedAmount;
  bool throughBankingChannel;

  ForeignIncomeInputModel({this.particular, required this.throughBankingChannel,this.exemptedAmount});
}