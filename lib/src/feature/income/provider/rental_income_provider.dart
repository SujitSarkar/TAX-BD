import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/model/rental_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';

class RentalIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<RentalIncomeInputModel> rentalIncomeInputList = [];

  void clearAllData(){
    rentalIncomeInputList=[];
    loading = false;
    functionLoading = false;
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addRentalIncomeInputListItem() {
    rentalIncomeInputList.add(RentalIncomeInputModel(
      locationAndDescription: TextEditingController(),
      rentReceived: TextEditingController(),
      advanceRentReceived: TextEditingController(),
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
      netIncome: TextEditingController(),
      taxpayerShare: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfRentalIncomeInputList(int index) async {
    rentalIncomeInputList.removeAt(index);
    await submitRentalIncomeButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  Future<void> getRentalIncomeData() async {
    rentalIncomeInputList = [];
    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.rentalIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          rentalIncomeInputList.add(RentalIncomeInputModel(
            locationAndDescription:
                TextEditingController(text: element['locationAndDescription']),
            rentReceived: TextEditingController(text: element['rentReceived']),
            advanceRentReceived:
                TextEditingController(text: element['advanceRentReceived']),
            valueOfAnyBenefits:
                TextEditingController(text: element['valueOfAnyBenefits']),
            adjustedAdvanceRent:
                TextEditingController(text: element['adjustedAdvanceRent']),
            vacancyAllowance:
                TextEditingController(text: element['vacancyAllowance']),
            totalRentIncome:
                TextEditingController(text: element['totalRentIncome']),
            repairAD: TextEditingController(text: element['repairAD']),
            municipalAD: TextEditingController(text: element['municipalAD']),
            landAD: TextEditingController(text: element['landAD']),
            interestAD: TextEditingController(text: element['interestAD']),
            insuranceAD: TextEditingController(text: element['insuranceAD']),
            otherAD: TextEditingController(text: element['otherAD']),
            totalAdmissibleDeduction: TextEditingController(
                text: element['totalAdmissibleDeduction']),
            netIncome: TextEditingController(text: element['netIncome']),
            taxpayerShare:
                TextEditingController(text: element['taxpayerShare']),
          ));
        }
      }
    } else {
      rentalIncomeInputList.add(RentalIncomeInputModel(
        locationAndDescription: TextEditingController(),
        rentReceived: TextEditingController(),
        advanceRentReceived: TextEditingController(),
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
        netIncome: TextEditingController(),
        taxpayerShare: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitRentalIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();

    final List<Map<String, dynamic>> rentalIncomeDataList = [];

    for (RentalIncomeInputModel element in rentalIncomeInputList) {

      ///Total Rental Value (1+2+3–4-5)
      final double sumOfRentalValue = (double.parse(
                  element.rentReceived!.text.isEmpty
                      ? '0.0'
                      : element.rentReceived!.text.trim()) +
              double.parse(element.advanceRentReceived!.text.isEmpty
                  ? '0.0'
                  : element.advanceRentReceived!.text.trim()) +
          double.parse(
              element.valueOfAnyBenefits!.text.isEmpty
                  ? '0.0'
                  : element.valueOfAnyBenefits!.text.trim()) ) -
          double.parse(element.adjustedAdvanceRent!.text.isEmpty
                  ? '0.0'
                  : element.adjustedAdvanceRent!.text.trim()) -
              double.parse(element.vacancyAllowance!.text.isEmpty
                  ? '0.0'
                  : element.vacancyAllowance!.text.trim());
      element.totalRentIncome!.text = '$sumOfRentalValue';

      final double totalAdmissibleDeductionValue = double.parse(
                  element.repairAD!.text.isEmpty
                      ? '0.0'
                      : element.repairAD!.text.trim()) +
              double.parse(element.municipalAD!.text.isEmpty
                  ? '0.0'
                  : element.municipalAD!.text.trim()) +
          (double.parse(element.landAD!.text.isEmpty
                  ? '0.0'
                  : element.landAD!.text.trim()) +
              double.parse(element.interestAD!.text.isEmpty
                  ? '0.0'
                  : element.interestAD!.text.trim()))+
          (double.parse(element.insuranceAD!.text.isEmpty
                  ? '0.0'
                  : element.insuranceAD!.text.trim()) +
              double.parse(element.otherAD!.text.isEmpty
                  ? '0.0'
                  : element.otherAD!.text.trim()));

      final double totalValueOfNetIncome = sumOfRentalValue - totalAdmissibleDeductionValue;

      element.totalAdmissibleDeduction!.text = '$totalAdmissibleDeductionValue';
      element.netIncome!.text = '$totalValueOfNetIncome';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'locationAndDescription': element.locationAndDescription!.text.trim(),
        'rentReceived': element.rentReceived!.text.trim(),
        'advanceRentReceived': element.advanceRentReceived!.text.trim(),
        'valueOfAnyBenefits': element.valueOfAnyBenefits!.text.trim(),
        'adjustedAdvanceRent': element.adjustedAdvanceRent!.text.trim(),
        'vacancyAllowance': element.vacancyAllowance!.text.trim(),
        'totalRentIncome': element.totalRentIncome!.text.trim(),
        'repairAD': element.repairAD!.text.trim(),
        'municipalAD': element.municipalAD!.text.trim(),
        'landAD': element.landAD!.text.trim(),
        'interestAD': element.interestAD!.text.trim(),
        'insuranceAD': element.insuranceAD!.text.trim(),
        'otherAD': element.otherAD!.text.trim(),
        'totalAdmissibleDeduction':
            element.totalAdmissibleDeduction!.text.trim(),
        'netIncome': element.netIncome!.text.trim(),
        'taxpayerShare': element.taxpayerShare!.text.trim(),
      };
      rentalIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> privateSalaryIncomeDataMap = {
      'data': rentalIncomeDataList
    };

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.rentalIncome, data: privateSalaryIncomeDataMap).then((result)async{
      if (result) {
        TaxCalculationProvider taxCalculationProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        AssetInfoProvider assetInfoProvider = Provider.of(AppNavigatorKey.key.currentState!.context,listen: false);
        await taxCalculationProvider.getTaxCalculationData();
        await assetInfoProvider.getAssetInfoData();
        showToast('Success');
      } else {
        showToast('Failed');
      }
    });
    functionLoading = false;
    notifyListeners();
  }
}
