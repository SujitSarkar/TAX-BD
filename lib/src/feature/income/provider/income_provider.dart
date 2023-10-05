import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/model/private_salary_income_data_model.dart';

class IncomeProvider extends ChangeNotifier {
  bool loading = false;

  List<PrivateSalaryIncomeInputModel> privateSalaryIncomeInputList = [
    PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowence: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareSceme: TextEditingController(),
        accomodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providendFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController())
  ];

  void addPrivateSalaryIncomeInputListItem() {
    privateSalaryIncomeInputList.add(PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowence: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareSceme: TextEditingController(),
        accomodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providendFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController()));
    notifyListeners();
  }
}
