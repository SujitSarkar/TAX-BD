import 'dart:convert';
import 'package:flutter/cupertino.dart';

String costInformationInputModelToJson(List<CostInformationInputModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostInformationInputModel {
  CostInformationInputModelItem? personalAndFoodingExpanses;
  CostInformationInputModelItem? accommodationExpanses;
  CostInformationInputModelItem? personalTransportExpanses;
  CostInformationInputModelItem? utilityExpanses;
  CostInformationInputModelItem? educationExpanses;
  CostInformationInputModelItem? personalExpanses;
  CostInformationInputModelItem? festivalExpanses;
  CostInformationInputModelItem? taxDeduction;
  CostInformationInputModelItem? interestPaid;

  CostInformationInputModel(
      {this.personalAndFoodingExpanses,
      this.accommodationExpanses,
      this.personalTransportExpanses,
      this.utilityExpanses,
      this.educationExpanses,
      this.personalExpanses,
      this.festivalExpanses,
      this.taxDeduction,
      this.interestPaid});

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
        "accommodationExpanses": accommodationExpanses,
        "personalTransportExpanses": personalTransportExpanses,
        "utilityExpanses": utilityExpanses,
        "educationExpanses": educationExpanses,
        "personalExpanses": personalExpanses,
        "festivalExpanses": festivalExpanses,
        "taxDeduction": taxDeduction,
        "interestPaid": interestPaid
      };
}

class CostInformationInputModelItem {
  final TextEditingController? amount;
  final TextEditingController? comment;

  CostInformationInputModelItem({this.amount, this.comment});

  // factory CostInformationInputModelItem.fromJson(Map<String, dynamic> json) =>
  //     CostInformationInputModelItem(
  //         amount: json["amount"], comment: json["comment"]);

  Map<String, dynamic> toJson() => {"amount": amount, "comment": comment};
}
