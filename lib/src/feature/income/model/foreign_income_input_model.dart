import 'package:flutter/cupertino.dart';

class ForeignIncomeInputModel{
  final TextEditingController? particular;
  bool throughBankingChannel;

  ForeignIncomeInputModel({this.particular, required this.throughBankingChannel});
}