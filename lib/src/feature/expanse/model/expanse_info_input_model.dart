import 'dart:convert';
import 'package:flutter/cupertino.dart';

String expanseInformationInputModelToJson(List<ExpanseInformationInputModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpanseInformationInputModel {
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

  ExpanseInformationInputModel(
      {this.personalAndFoodingExpanses,
      this.houseExpanse,
      this.personalTransportExpanses,
      this.utilityExpanses,
      this.educationExpanses,
      this.personalExpanses,
      this.festivalExpanses,
      this.taxDeduction,
      this.interestPaid,this.total});

  // factory CostInformationInputModel.fromJson(Map<String, dynamic> json) =>
  //     CostInformationInputModel(
  //         particularOfExpenditure: json["particularOfExpenditure"],
  //         particularAndFoodingExpanses: json["particularAndFoodingExpanses"],
  //         accommodationExpanses: json["accommodationExpanses"],
  //         personalTransportExpanses: json["personalTransportExpanses"],
  //         utilityExpanses: json["utilityExpanses"],
  //         educationExpanses: json["educationExpanses"],
  //         personalExpanses: json["personalExpanses"],
  //         festivalExpanses: json["festivalExpanses"],
  //         taxDeduction: json["taxDeduction"],
  //         interestPaid: json["interestPaid"]);

  Map<String, dynamic> toJson() => {
        "particularAndFoodingExpanses": personalAndFoodingExpanses,
        "houseExpanses": houseExpanse,
        "personalTransportExpanses": personalTransportExpanses,
        "utilityExpanses": utilityExpanses,
        "educationExpanses": educationExpanses,
        "personalExpanses": personalExpanses,
        "festivalExpanses": festivalExpanses,
        "taxDeduction": taxDeduction,
        "interestPaid": interestPaid,
        "total": total
      };
}

class ExpanseInformationInputModelItem {
  final TextEditingController? amount;
  final TextEditingController? comment;

  ExpanseInformationInputModelItem({this.amount, this.comment});

  // factory ExpanseInformationInputModelItem.fromJson(Map<String, dynamic> json) =>
  //     ExpanseInformationInputModelItem(
  //         amount: json["amount"], comment: json["comment"]);

  Map<String, dynamic> toJson() => {"amount": amount, "comment": comment};
}
