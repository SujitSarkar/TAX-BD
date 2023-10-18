import 'package:flutter/cupertino.dart';

class ExpenseInformationInputModel {
  ExpanseInformationInputModelItem? personalAndFoodingExpanses;
  ExpanseInformationInputModelItem? houseExpanse;
  ExpanseInformationInputModelItem? personalTransportExpanses;
  ExpanseInformationInputModelItem? utilityExpanses;
  ExpanseInformationInputModelItem? educationExpanses;
  ExpanseInformationInputModelItem? personalExpanses;
  ExpanseInformationInputModelItem? festivalExpanses;
  ExpanseInformationInputModelItem? taxDeduction;
  ExpanseInformationInputModelItem? interestPaid;
  final TextEditingController? total;

  ExpenseInformationInputModel(
      {this.personalAndFoodingExpanses,
      this.houseExpanse,
      this.personalTransportExpanses,
      this.utilityExpanses,
      this.educationExpanses,
      this.personalExpanses,
      this.festivalExpanses,
      this.taxDeduction,
      this.interestPaid,this.total});
}

class ExpanseInformationInputModelItem {
  final TextEditingController? amount;
  final TextEditingController? comment;
  ExpanseInformationInputModelItem({this.amount, this.comment});

}
