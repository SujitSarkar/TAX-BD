import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/model/private_salary_income_input_model.dart';
import '../../../constant/app_toast.dart';

class SalaryIncomeProvider extends ChangeNotifier {
  bool loading = false;

  List<PrivateSalaryIncomeInputModel> privateSalaryIncomeInputList = [
    PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowance: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareScheme: TextEditingController(),
        accommodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providentFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController())
  ];

  List<PrivateSalaryIncomeInputModel> govtSalaryIncomeInputList = [
    PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowance: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareScheme: TextEditingController(),
        accommodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providentFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController())
  ];

  void addPrivateSalaryIncomeInputListItem() {
    privateSalaryIncomeInputList.add(PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowance: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareScheme: TextEditingController(),
        accommodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providentFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfPrivateSalaryIncomeInputList(int index){
    privateSalaryIncomeInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }

  ///Govt
  void addGovtSalaryIncomeInputListItem() {
    govtSalaryIncomeInputList.add(PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowance: TextEditingController(),
        advanceSalary: TextEditingController(),
        benefits: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareScheme: TextEditingController(),
        accommodationBenefits: TextEditingController(),
        carBenefits: TextEditingController(),
        anyOtherBenefits: TextEditingController(),
        providentFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryIncome: TextEditingController(),
        exemptedSalary: TextEditingController(),
        totalIncomeFromSalary: TextEditingController()));
    notifyListeners();
  }

  void removeItemOfGovtSalaryIncomeInputList(int index){
    govtSalaryIncomeInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
