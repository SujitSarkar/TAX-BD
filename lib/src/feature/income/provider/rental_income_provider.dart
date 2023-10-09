import 'package:flutter/Material.dart';
import 'package:tax_bd/src/feature/income/model/rental_income_input_model.dart';
import '../../../constant/app_toast.dart';

class RentalIncomeProvider extends ChangeNotifier {
  bool loading = false;

  List<RentalIncomeInputModel> rentalIncomeInputList = [
    RentalIncomeInputModel(
      locationAndDescription: TextEditingController(),
      rentReceipt: TextEditingController(),
      advanceRentReceipt: TextEditingController(),
      valueOfAnyBenefits: TextEditingController(),
      adjustedAdvanceRent: TextEditingController(),
      vacancyAllowance: TextEditingController(),
      totalRentIncome: TextEditingController(),
      repairAD: TextEditingController(),
      municipalAD: TextEditingController(),
      landAD: TextEditingController(),
      interestAD: TextEditingController(),
      insuranceAD: TextEditingController(),
      otherAD: TextEditingController(),
      totalAdmissibleDeduction: TextEditingController(),
      incomeFromHouseProperty: TextEditingController(),
      inCaseOfPartial: TextEditingController(),
    )
  ];

  void addRentalIncomeInputListItem() {
    rentalIncomeInputList.add(RentalIncomeInputModel(
      locationAndDescription: TextEditingController(),
      rentReceipt: TextEditingController(),
      advanceRentReceipt: TextEditingController(),
      valueOfAnyBenefits: TextEditingController(),
      adjustedAdvanceRent: TextEditingController(),
      vacancyAllowance: TextEditingController(),
      totalRentIncome: TextEditingController(),
      repairAD: TextEditingController(),
      municipalAD: TextEditingController(),
      landAD: TextEditingController(),
      interestAD: TextEditingController(),
      insuranceAD: TextEditingController(),
      otherAD: TextEditingController(),
      totalAdmissibleDeduction: TextEditingController(),
      incomeFromHouseProperty: TextEditingController(),
      inCaseOfPartial: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfRentalIncomeInputList(int index) {
    rentalIncomeInputList.removeAt(index);
    notifyListeners();
    showToast('Item deleted');
  }
}
