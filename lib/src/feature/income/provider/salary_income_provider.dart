import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/feature/income/model/private_salary_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/govt_salary_income_input_model.dart';

class SalaryIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<PrivateSalaryIncomeInputModel> privateSalaryIncomeInputList = [];
  List<GovtSalaryIncomeInputModel> govtSalaryIncomeInputList = [];

  void clearAllData(){
    privateSalaryIncomeInputList=[];
    govtSalaryIncomeInputList=[];
    loading = false;
    functionLoading = false;
  }

  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  ///Private Salary
  void changeRentFreeAccommodation(int index, bool newValue) {
    privateSalaryIncomeInputList[index].rentFreeAccommodation = newValue;
    notifyListeners();
  }
  void changeAccommodationConcessionalRate(int index, bool newValue) {
    privateSalaryIncomeInputList[index].accommodationAtConcessionalRate = newValue;
    notifyListeners();
  }
  void changeVehicleFacilityProvided(int index, bool newValue) {
    privateSalaryIncomeInputList[index].vehicleFacilityProvided = newValue;
    notifyListeners();
  }
  void changeOtherNonCashBenefit(int index, bool newValue) {
    privateSalaryIncomeInputList[index].hasOtherNonCashBenefit = newValue;
    notifyListeners();
  }
  void changeVehicleCCLimit(int index, String? newValue) {
    privateSalaryIncomeInputList[index].vehicleCC = newValue;
    notifyListeners();
  }

  void addPrivateSalaryIncomeInputListItem() {
    privateSalaryIncomeInputList.add(
      PrivateSalaryIncomeInputModel(
       nameOfEmployer : TextEditingController(),
       employerDesignation : TextEditingController(),
       basicSalary : TextEditingController(),
       houseRentAllowance : TextEditingController(),
       medicalAllowance : TextEditingController(),
       conveyanceAllowance : TextEditingController(),
       festivalBonus : TextEditingController(),
       others : TextEditingController(),
       totalIncomeFromSalary : TextEditingController(),
       exempted : TextEditingController(),
       rentFreeAccommodation : false,
       rentFreeAccommodationValue : TextEditingController(),
       rentFreeAccommodationMonth : TextEditingController(),
       accommodationAtConcessionalRate:false,
       concessionalRateValue : TextEditingController(),
       concessionalRateMonth : TextEditingController(),
       rentPaidByTaxpayer : TextEditingController(),
       vehicleFacilityProvided:false,
       vehicleCC: DummyData.vehicleCCList.first,
       vehicleFacilityMonth : TextEditingController(),
       hasOtherNonCashBenefit: false,
       otherNonCashBenefit : OtherInputModel(
        particular: TextEditingController(),
        value: TextEditingController(),
      ),
      ),
    );
    notifyListeners();
  }

  void removeItemOfPrivateSalaryIncomeInputList(int index) async {
    privateSalaryIncomeInputList.removeAt(index);
    await submitPrivateSalaryIncomeButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  Future<void> getPrivateSalaryIncomeData() async {
    privateSalaryIncomeInputList = [];
    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.privateSalaryIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          privateSalaryIncomeInputList.add(
            PrivateSalaryIncomeInputModel(
              nameOfEmployer : TextEditingController(text: element['nameOfEmployer']),
              employerDesignation : TextEditingController(text: element['employerDesignation']),
              basicSalary : TextEditingController(text: element['basicSalary']),
              houseRentAllowance : TextEditingController(text: element['houseRentAllowance']),
              medicalAllowance : TextEditingController(text: element['medicalAllowance']),
              conveyanceAllowance : TextEditingController(text: element['conveyanceAllowance']),
              festivalBonus : TextEditingController(text: element['festivalBonus']),
              others : TextEditingController(text: element['others']),
              totalIncomeFromSalary : TextEditingController(text: element['totalIncomeFromSalary']),
              exempted : TextEditingController(text: element['exempted']),
              rentFreeAccommodation : element['rentFreeAccommodation'],
              rentFreeAccommodationValue : TextEditingController(text: element['rentFreeAccommodationValue']),
              rentFreeAccommodationMonth : TextEditingController(text: element['rentFreeAccommodationMonth']),
              accommodationAtConcessionalRate: element['accommodationAtConcessionalRate'],
              concessionalRateValue : TextEditingController(text: element['concessionalRateValue']),
              concessionalRateMonth : TextEditingController(text: element['concessionalRateMonth']),
              rentPaidByTaxpayer : TextEditingController(text: element['rentPaidByTaxpayer']),
              vehicleFacilityProvided: element['vehicleFacilityProvided'],
              vehicleCC: element['vehicleCC'],
              vehicleFacilityMonth : TextEditingController(text: element['vehicleFacilityMonth']),
              hasOtherNonCashBenefit: element['hasOtherNonCashBenefit'],
              otherNonCashBenefit : OtherInputModel(
                particular: TextEditingController(text: element['otherNonCashBenefit']['particular']),
                value: TextEditingController(text: element['otherNonCashBenefit']['value']),
              ),
            ),
          );
        }
      }
    } else {
      privateSalaryIncomeInputList.add(
        PrivateSalaryIncomeInputModel(
          nameOfEmployer : TextEditingController(),
          employerDesignation : TextEditingController(),
          basicSalary : TextEditingController(),
          houseRentAllowance : TextEditingController(),
          medicalAllowance : TextEditingController(),
          conveyanceAllowance : TextEditingController(),
          festivalBonus : TextEditingController(),
          others : TextEditingController(),
          totalIncomeFromSalary : TextEditingController(),
          exempted : TextEditingController(),
          rentFreeAccommodation : false,
          rentFreeAccommodationValue : TextEditingController(),
          rentFreeAccommodationMonth : TextEditingController(),
          accommodationAtConcessionalRate:false,
          concessionalRateValue : TextEditingController(),
          concessionalRateMonth: TextEditingController(),
          rentPaidByTaxpayer : TextEditingController(),
          vehicleFacilityProvided:false,
          vehicleCC: DummyData.vehicleCCList.first,
          vehicleFacilityMonth : TextEditingController(),
          hasOtherNonCashBenefit: false,
          otherNonCashBenefit : OtherInputModel(
            particular: TextEditingController(),
            value: TextEditingController(),
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> submitPrivateSalaryIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> privateSalaryIncomeDataList = [];

    for (PrivateSalaryIncomeInputModel element
        in privateSalaryIncomeInputList) {
      ///Total Income
      final double totalIncomeFromSalaryValue = double.parse(
              element.basicSalary!.text.isEmpty
                  ? '0.0'
                  : element.basicSalary!.text.trim()) +
          double.parse(element.houseRentAllowance!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.text.trim()) +
          double.parse(element.medicalAllowance!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.text.trim()) +
          double.parse(element.conveyanceAllowance!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.text.trim()) +
          double.parse(element.festivalBonus!.text.isEmpty
              ? '0.0'
              : element.festivalBonus!.text.trim()) +
          double.parse(element.others!.text.isEmpty ? '0.0' : element.others!.text.trim());
      element.totalIncomeFromSalary!.text = '$totalIncomeFromSalaryValue';

      ///Exempted
    final double exemptedValue = min((totalIncomeFromSalaryValue/3), 450000);
    element.exempted!.text = '$exemptedValue';

      ///Rent Free Accommodation
      if(element.rentFreeAccommodation!){
        final double totalRentFreeAccommodationValue = double.parse(
            element.rentFreeAccommodationValue!.text.isEmpty
                ? '0.0'
                : element.rentFreeAccommodationValue!.text.trim())
            * double.parse(
                element.rentFreeAccommodationMonth!.text.isEmpty
                    ? '0.0'
                    : element.rentFreeAccommodationMonth!.text.trim());

        element.totalIncomeFromSalary!.text =
        '${double.parse(element.totalIncomeFromSalary!.text.isNotEmpty?element.totalIncomeFromSalary!.text:'0.0')
            + totalRentFreeAccommodationValue}';
      }
      ///Accommodation at Concessional Rate
      if(element.accommodationAtConcessionalRate!){
        final double totalConcessionalRateValue = (double.parse(
            element.concessionalRateValue!.text.isEmpty
                ? '0.0'
                : element.concessionalRateValue!.text.trim()) -
            double.parse(
                element.rentPaidByTaxpayer!.text.isEmpty
                    ? '0.0'
                    : element.rentPaidByTaxpayer!.text.trim())) *
            double.parse(
                element.concessionalRateMonth!.text.isEmpty
                    ? '0.0'
                    : element.concessionalRateMonth!.text.trim());

        element.totalIncomeFromSalary!.text =
        '${double.parse(element.totalIncomeFromSalary!.text.isNotEmpty?element.totalIncomeFromSalary!.text:'0.0')
            + totalConcessionalRateValue}';
      }
      ///Vehicle Facility Provided
      if(element.vehicleFacilityProvided!){
        double totalVehicleFacilityProvidedValue = 0.0;
        if(element.vehicleCC == DummyData.vehicleCCList.first){
          totalVehicleFacilityProvidedValue = 10000.0* double.parse(
              element.vehicleFacilityMonth!.text.isEmpty
                  ? '0.0'
                  : element.vehicleFacilityMonth!.text.trim());
        }else{
          totalVehicleFacilityProvidedValue = 25000.0* double.parse(
              element.vehicleFacilityMonth!.text.isEmpty
                  ? '0.0'
                  : element.vehicleFacilityMonth!.text.trim());
        }
        element.totalIncomeFromSalary!.text =
        '${double.parse(element.totalIncomeFromSalary!.text.isNotEmpty?element.totalIncomeFromSalary!.text:'0.0')
            + totalVehicleFacilityProvidedValue}';
      }
      ///Other Non-Cash Benefit
      if(element.hasOtherNonCashBenefit!){
        final double totalOtherNonCashBenefitValue = double.parse(
            element.otherNonCashBenefit!.value!.text.isEmpty
                ? '0.0'
                : element.otherNonCashBenefit!.value!.text.trim());

        element.totalIncomeFromSalary!.text =
        '${double.parse(element.totalIncomeFromSalary!.text.isNotEmpty
            ? element.totalIncomeFromSalary!.text
            : '0.0')
            + totalOtherNonCashBenefitValue}';
      }
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'nameOfEmployer' : element.nameOfEmployer!.text.trim(),
        'employerDesignation' : element.employerDesignation!.text.trim(),
        'basicSalary' : element.basicSalary!.text.trim(),
        'houseRentAllowance' : element.houseRentAllowance!.text.trim(),
        'medicalAllowance' : element.medicalAllowance!.text.trim(),
        'conveyanceAllowance' : element.conveyanceAllowance!.text.trim(),
        'festivalBonus' : element.festivalBonus!.text.trim(),
        'others' : element.others!.text.trim(),
        'totalIncomeFromSalary' : element.totalIncomeFromSalary!.text.trim(),
        'exempted' : element.exempted!.text.trim(),
        'rentFreeAccommodation' : element.rentFreeAccommodation,
        'rentFreeAccommodationValue' : element.rentFreeAccommodationValue!.text.trim(),
        'rentFreeAccommodationMonth' : element.rentFreeAccommodationMonth!.text.trim(),
        'accommodationAtConcessionalRate': element.accommodationAtConcessionalRate,
        'concessionalRateValue' : element.concessionalRateValue!.text.trim(),
        'concessionalRateMonth' : element.concessionalRateMonth!.text.trim(),
        'rentPaidByTaxpayer' : element.rentPaidByTaxpayer!.text.trim(),
        'vehicleFacilityProvided': element.vehicleFacilityProvided,
        'vehicleCC': element.vehicleCC,
        'vehicleFacilityMonth' : element.vehicleFacilityMonth!.text.trim(),
        'hasOtherNonCashBenefit': element.hasOtherNonCashBenefit,
        'otherNonCashBenefit' : {
          'particular': element.otherNonCashBenefit!.particular!.text.trim(),
          'value': element.otherNonCashBenefit!.value!.text.trim(),
        },
      };
      privateSalaryIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> privateSalaryIncomeDataMap = {
      'data': privateSalaryIncomeDataList
    };

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.privateSalaryIncome,
        data: privateSalaryIncomeDataMap).then((result)async{
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

  ///Govt Salary:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addGovtSalaryIncomeInputListItem() {
    govtSalaryIncomeInputList.add(
      GovtSalaryIncomeInputModel(
        basicPay: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        arrearPay: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        specialAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        houseRentAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        medicalAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        conveyanceAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        festivalAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        supportStaffAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        leaveAllowance: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        honorariumReward: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        overtimeAllowances: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        banglaNoboborshoAllowances: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        interestAccruedOnProvidentFund: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        lumpGrant: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        gratuity: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        others: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
        total: GovtSalaryIncomeInputModelItem(
            amount: TextEditingController(),
            exempted: TextEditingController(),
            taxable: TextEditingController()),
      ),
    );
    notifyListeners();
  }

  void removeItemOfGovtSalaryIncomeInputList(int index) async {
    govtSalaryIncomeInputList.removeAt(index);
    await submitGovtSalaryIncomeButtonOnTap();
    showToast('Item deleted');
    notifyListeners();
  }

  Future<void> getGovtSalaryIncomeData() async {
    govtSalaryIncomeInputList = [];
    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.govtSalaryIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          govtSalaryIncomeInputList.add(
            GovtSalaryIncomeInputModel(
              basicPay: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['basicPay']['amount']),
                  exempted: TextEditingController(
                      text: element['basicPay']['exempted']),
                  taxable: TextEditingController(
                      text: element['basicPay']['taxable'])),
              arrearPay: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['arrearPay']['amount']),
                  exempted: TextEditingController(
                      text: element['arrearPay']['exempted']),
                  taxable: TextEditingController(
                      text: element['arrearPay']['taxable'])),
              specialAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['specialAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['specialAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['specialAllowance']['taxable'])),
              houseRentAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['houseRentAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['houseRentAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['houseRentAllowance']['taxable'])),
              medicalAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['medicalAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['medicalAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['medicalAllowance']['taxable'])),
              conveyanceAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['conveyanceAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['conveyanceAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['conveyanceAllowance']['taxable'])),
              festivalAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['festivalAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['festivalAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['festivalAllowance']['taxable'])),
              supportStaffAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['supportStaffAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['supportStaffAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['supportStaffAllowance']['taxable'])),
              leaveAllowance: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['leaveAllowance']['amount']),
                  exempted: TextEditingController(
                      text: element['leaveAllowance']['exempted']),
                  taxable: TextEditingController(
                      text: element['leaveAllowance']['taxable'])),
              honorariumReward: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['honorariumReward']['amount']),
                  exempted: TextEditingController(
                      text: element['honorariumReward']['exempted']),
                  taxable: TextEditingController(
                      text: element['honorariumReward']['taxable'])),
              overtimeAllowances: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['overtimeAllowances']['amount']),
                  exempted: TextEditingController(
                      text: element['overtimeAllowances']['exempted']),
                  taxable: TextEditingController(
                      text: element['overtimeAllowances']['taxable'])),
              banglaNoboborshoAllowances: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['banglaNoboborshoAllowances']['amount']),
                  exempted: TextEditingController(
                      text: element['banglaNoboborshoAllowances']['exempted']),
                  taxable: TextEditingController(
                      text: element['banglaNoboborshoAllowances']['taxable'])),
              interestAccruedOnProvidentFund: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['interestAccruedOnProvidentFund']
                          ['amount']),
                  exempted: TextEditingController(
                      text: element['interestAccruedOnProvidentFund']
                          ['exempted']),
                  taxable: TextEditingController(
                      text: element['interestAccruedOnProvidentFund']
                          ['taxable'])),
              lumpGrant: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['lumpGrant']['amount']),
                  exempted: TextEditingController(
                      text: element['lumpGrant']['exempted']),
                  taxable: TextEditingController(
                      text: element['lumpGrant']['taxable'])),
              gratuity: GovtSalaryIncomeInputModelItem(
                  amount: TextEditingController(
                      text: element['gratuity']['amount']),
                  exempted: TextEditingController(
                      text: element['gratuity']['exempted']),
                  taxable: TextEditingController(
                      text: element['gratuity']['taxable'])),
              others: GovtSalaryIncomeInputModelItem(
                  amount:
                      TextEditingController(text: element['others']['amount']),
                  exempted: TextEditingController(
                      text: element['others']['exempted']),
                  taxable: TextEditingController(
                      text: element['others']['taxable'])),
              total: GovtSalaryIncomeInputModelItem(
                  amount:
                      TextEditingController(text: element['total']['amount']),
                  exempted:
                      TextEditingController(text: element['total']['exempted']),
                  taxable:
                      TextEditingController(text: element['total']['taxable'])),
            ),
          );
        }
      }
    } else {
      govtSalaryIncomeInputList.add(
        GovtSalaryIncomeInputModel(
          basicPay: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          arrearPay: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          specialAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          houseRentAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          medicalAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          conveyanceAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          festivalAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          supportStaffAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          leaveAllowance: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          honorariumReward: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          overtimeAllowances: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          banglaNoboborshoAllowances: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          interestAccruedOnProvidentFund: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          lumpGrant: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          gratuity: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          others: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
          total: GovtSalaryIncomeInputModelItem(
              amount: TextEditingController(),
              exempted: TextEditingController(),
              taxable: TextEditingController()),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> submitGovtSalaryIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> govtSalaryIncomeDataList = [];

    for (GovtSalaryIncomeInputModel element in govtSalaryIncomeInputList) {
      ///Exempted calculation
      element.basicPay!.taxable!.text = (double.parse(
          element.basicPay!.amount!.text.isEmpty
              ? '0.0'
              : element.basicPay!.amount!.text.trim()) - double.parse(
          element.basicPay!.exempted!.text.isEmpty
              ? '0.0'
              : element.basicPay!.exempted!.text.trim())).toString();

      element.arrearPay!.taxable!.text = (double.parse(
          element.arrearPay!.amount!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.amount!.text.trim()) - double.parse(
          element.arrearPay!.exempted!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.exempted!.text.trim())).toString();

      element.specialAllowance!.taxable!.text = (double.parse(
          element.specialAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.amount!.text.trim()) - double.parse(
          element.specialAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.exempted!.text.trim())).toString();
      element.houseRentAllowance!.taxable!.text = (double.parse(
          element.houseRentAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.amount!.text.trim()) - double.parse(
          element.houseRentAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.exempted!.text.trim())).toString();
      element.medicalAllowance!.taxable!.text = (double.parse(
          element.medicalAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.amount!.text.trim()) - double.parse(
          element.medicalAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.exempted!.text.trim())).toString();
      element.conveyanceAllowance!.taxable!.text = (double.parse(
          element.conveyanceAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.amount!.text.trim()) - double.parse(
          element.conveyanceAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.exempted!.text.trim())).toString();
      element.festivalAllowance!.taxable!.text = (double.parse(
          element.festivalAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.amount!.text.trim()) - double.parse(
          element.festivalAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.exempted!.text.trim())).toString();
      element.supportStaffAllowance!.taxable!.text = (double.parse(
          element.supportStaffAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.amount!.text.trim()) - double.parse(
          element.supportStaffAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.exempted!.text.trim())).toString();
      element.leaveAllowance!.taxable!.text = (double.parse(
          element.leaveAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.amount!.text.trim()) - double.parse(
          element.leaveAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.exempted!.text.trim())).toString();
      element.honorariumReward!.taxable!.text = (double.parse(
          element.honorariumReward!.amount!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.amount!.text.trim()) - double.parse(
          element.honorariumReward!.exempted!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.exempted!.text.trim())).toString();
      element.overtimeAllowances!.taxable!.text = (double.parse(
          element.overtimeAllowances!.amount!.text.isEmpty
              ? '0.0'
              : element.overtimeAllowances!.amount!.text.trim()) - double.parse(
          element.overtimeAllowances!.exempted!.text.isEmpty
              ? '0.0'
              : element.overtimeAllowances!.exempted!.text.trim())).toString();
      element.banglaNoboborshoAllowances!.taxable!.text = (double.parse(
          element.banglaNoboborshoAllowances!.amount!.text.isEmpty
              ? '0.0'
              : element.banglaNoboborshoAllowances!.amount!.text.trim()) - double.parse(
          element.banglaNoboborshoAllowances!.exempted!.text.isEmpty
              ? '0.0'
              : element.banglaNoboborshoAllowances!.exempted!.text.trim())).toString();

      element.interestAccruedOnProvidentFund!.taxable!.text = (double.parse(
          element.interestAccruedOnProvidentFund!.amount!.text.isEmpty
              ? '0.0'
              : element.interestAccruedOnProvidentFund!.amount!.text.trim()) - double.parse(
          element.interestAccruedOnProvidentFund!.exempted!.text.isEmpty
              ? '0.0'
              : element.interestAccruedOnProvidentFund!.exempted!.text.trim())).toString();
      element.lumpGrant!.taxable!.text = (double.parse(
          element.lumpGrant!.amount!.text.isEmpty
              ? '0.0'
              : element.lumpGrant!.amount!.text.trim()) - double.parse(
          element.lumpGrant!.exempted!.text.isEmpty
              ? '0.0'
              : element.lumpGrant!.exempted!.text.trim())).toString();
      element.gratuity!.taxable!.text = (double.parse(
          element.gratuity!.amount!.text.isEmpty
              ? '0.0'
              : element.gratuity!.amount!.text.trim()) - double.parse(
          element.gratuity!.exempted!.text.isEmpty
              ? '0.0'
              : element.gratuity!.exempted!.text.trim())).toString();
      element.others!.taxable!.text = (double.parse(
          element.others!.amount!.text.isEmpty
              ? '0.0'
              : element.others!.amount!.text.trim()) - double.parse(
          element.others!.exempted!.text.isEmpty
              ? '0.0'
              : element.others!.exempted!.text.trim())).toString();

      ///Total Calculation
      final double totalAmountValue = double.parse(
              element.basicPay!.amount!.text.isEmpty
                  ? '0.0'
                  : element.basicPay!.amount!.text.trim()) +
          double.parse(element.arrearPay!.amount!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.amount!.text.trim()) +
          double.parse(element.specialAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.amount!.text.trim()) +
          double.parse(element.houseRentAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.amount!.text.trim()) +
          double.parse(element.medicalAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.amount!.text.trim()) +
          double.parse(element.conveyanceAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.amount!.text.trim()) +
          double.parse(element.festivalAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.amount!.text.trim()) +
          double.parse(element.supportStaffAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.amount!.text.trim()) +
          double.parse(element.leaveAllowance!.amount!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.amount!.text.trim()) +
          double.parse(element.honorariumReward!.amount!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.amount!.text.trim()) +
          double.parse(
              element.overtimeAllowances!.amount!.text.isEmpty ? '0.0' : element.overtimeAllowances!.amount!.text.trim()) +
          double.parse(element.banglaNoboborshoAllowances!.amount!.text.isEmpty ? '0.0' : element.banglaNoboborshoAllowances!.amount!.text.trim()) +
          double.parse(element.interestAccruedOnProvidentFund!.amount!.text.isEmpty ? '0.0' : element.interestAccruedOnProvidentFund!.amount!.text.trim()) +
          double.parse(element.lumpGrant!.amount!.text.isEmpty ? '0.0' : element.lumpGrant!.amount!.text.trim()) +
          double.parse(element.gratuity!.amount!.text.isEmpty ? '0.0' : element.gratuity!.amount!.text.trim()) +
          double.parse(element.others!.amount!.text.isEmpty ? '0.0' : element.others!.amount!.text.trim());

      final double totalExemptedValue = double.parse(
          element.basicPay!.exempted!.text.isEmpty
              ? '0.0'
              : element.basicPay!.exempted!.text.trim()) +
          double.parse(element.arrearPay!.exempted!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.exempted!.text.trim()) +
          double.parse(element.specialAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.exempted!.text.trim()) +
          double.parse(element.houseRentAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.exempted!.text.trim()) +
          double.parse(element.medicalAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.exempted!.text.trim()) +
          double.parse(element.conveyanceAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.exempted!.text.trim()) +
          double.parse(element.festivalAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.exempted!.text.trim()) +
          double.parse(element.supportStaffAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.exempted!.text.trim()) +
          double.parse(element.leaveAllowance!.exempted!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.exempted!.text.trim()) +
          double.parse(element.honorariumReward!.exempted!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.exempted!.text.trim()) +
          double.parse(
              element.overtimeAllowances!.exempted!.text.isEmpty ? '0.0' : element.overtimeAllowances!.exempted!.text.trim()) +
          double.parse(element.banglaNoboborshoAllowances!.exempted!.text.isEmpty ? '0.0' : element.banglaNoboborshoAllowances!.exempted!.text.trim()) +
          double.parse(element.interestAccruedOnProvidentFund!.exempted!.text.isEmpty ? '0.0' : element.interestAccruedOnProvidentFund!.exempted!.text.trim()) +
          double.parse(element.lumpGrant!.exempted!.text.isEmpty ? '0.0' : element.lumpGrant!.exempted!.text.trim()) +
          double.parse(element.gratuity!.exempted!.text.isEmpty ? '0.0' : element.gratuity!.exempted!.text.trim()) +
          double.parse(element.others!.exempted!.text.isEmpty ? '0.0' : element.others!.exempted!.text.trim());

      final double totalTaxableValue = double.parse(
          element.basicPay!.taxable!.text.isEmpty
              ? '0.0'
              : element.basicPay!.taxable!.text.trim()) +
          double.parse(element.arrearPay!.taxable!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.taxable!.text.trim()) +
          double.parse(element.specialAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.taxable!.text.trim()) +
          double.parse(element.houseRentAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.taxable!.text.trim()) +
          double.parse(element.medicalAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.taxable!.text.trim()) +
          double.parse(element.conveyanceAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.taxable!.text.trim()) +
          double.parse(element.festivalAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.taxable!.text.trim()) +
          double.parse(element.supportStaffAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.taxable!.text.trim()) +
          double.parse(element.leaveAllowance!.taxable!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.taxable!.text.trim()) +
          double.parse(element.honorariumReward!.taxable!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.taxable!.text.trim()) +
          double.parse(
              element.overtimeAllowances!.taxable!.text.isEmpty ? '0.0' : element.overtimeAllowances!.taxable!.text.trim()) +
          double.parse(element.banglaNoboborshoAllowances!.taxable!.text.isEmpty ? '0.0' : element.banglaNoboborshoAllowances!.taxable!.text.trim()) +
          double.parse(element.interestAccruedOnProvidentFund!.taxable!.text.isEmpty ? '0.0' : element.interestAccruedOnProvidentFund!.taxable!.text.trim()) +
          double.parse(element.lumpGrant!.taxable!.text.isEmpty ? '0.0' : element.lumpGrant!.taxable!.text.trim()) +
          double.parse(element.gratuity!.taxable!.text.isEmpty ? '0.0' : element.gratuity!.taxable!.text.trim()) +
          double.parse(element.others!.taxable!.text.isEmpty ? '0.0' : element.others!.taxable!.text.trim());

      element.total!.amount!.text = '$totalAmountValue';
      element.total!.exempted!.text = '$totalExemptedValue';
      element.total!.taxable!.text = '$totalTaxableValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'basicPay': {
          'amount': element.basicPay!.amount!.text,
          'exempted': element.basicPay!.exempted!.text,
          'taxable': element.basicPay!.taxable!.text
        },
        'arrearPay': {
          'amount': element.arrearPay!.amount!.text,
          'exempted': element.arrearPay!.exempted!.text,
          'taxable': element.arrearPay!.taxable!.text
        },
        'specialAllowance': {
          'amount': element.specialAllowance!.amount!.text,
          'exempted': element.specialAllowance!.exempted!.text,
          'taxable': element.specialAllowance!.taxable!.text
        },
        'houseRentAllowance': {
          'amount': element.houseRentAllowance!.amount!.text,
          'exempted': element.houseRentAllowance!.exempted!.text,
          'taxable': element.houseRentAllowance!.taxable!.text
        },
        'medicalAllowance': {
          'amount': element.medicalAllowance!.amount!.text,
          'exempted': element.medicalAllowance!.exempted!.text,
          'taxable': element.medicalAllowance!.taxable!.text
        },
        'conveyanceAllowance': {
          'amount': element.conveyanceAllowance!.amount!.text,
          'exempted': element.conveyanceAllowance!.exempted!.text,
          'taxable': element.conveyanceAllowance!.taxable!.text
        },
        'festivalAllowance': {
          'amount': element.festivalAllowance!.amount!.text,
          'exempted': element.festivalAllowance!.exempted!.text,
          'taxable': element.festivalAllowance!.taxable!.text
        },
        'supportStaffAllowance': {
          'amount': element.supportStaffAllowance!.amount!.text,
          'exempted': element.supportStaffAllowance!.exempted!.text,
          'taxable': element.supportStaffAllowance!.taxable!.text
        },
        'leaveAllowance': {
          'amount': element.leaveAllowance!.amount!.text,
          'exempted': element.leaveAllowance!.exempted!.text,
          'taxable': element.leaveAllowance!.taxable!.text
        },
        'honorariumReward': {
          'amount': element.honorariumReward!.amount!.text,
          'exempted': element.honorariumReward!.exempted!.text,
          'taxable': element.honorariumReward!.taxable!.text
        },
        'overtimeAllowances': {
          'amount': element.overtimeAllowances!.amount!.text,
          'exempted': element.overtimeAllowances!.exempted!.text,
          'taxable': element.overtimeAllowances!.taxable!.text
        },
        'banglaNoboborshoAllowances': {
          'amount': element.banglaNoboborshoAllowances!.amount!.text,
          'exempted': element.banglaNoboborshoAllowances!.exempted!.text,
          'taxable': element.banglaNoboborshoAllowances!.taxable!.text
        },
        'interestAccruedOnProvidentFund':
        {
          'amount': element.interestAccruedOnProvidentFund!.amount!.text,
          'exempted': element.interestAccruedOnProvidentFund!.exempted!.text,
          'taxable': element.interestAccruedOnProvidentFund!.taxable!.text
        },
        'lumpGrant': {
          'amount': element.lumpGrant!.amount!.text,
          'exempted': element.lumpGrant!.exempted!.text,
          'taxable': element.lumpGrant!.taxable!.text
        },
        'gratuity': {
          'amount': element.gratuity!.amount!.text,
          'exempted': element.gratuity!.exempted!.text,
          'taxable': element.gratuity!.taxable!.text
        },
        'others':{
          'amount': element.others!.amount!.text,
          'exempted': element.others!.exempted!.text,
          'taxable': element.others!.taxable!.text
        },
        'total': {
          'amount': element.total!.amount!.text,
          'exempted': element.total!.exempted!.text,
          'taxable': element.total!.taxable!.text
        },
      };
      govtSalaryIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> govtSalaryIncomeDataMap = {
      'data': govtSalaryIncomeDataList
    };

    await firebaseDbHelper.insertData(
        childPath: DbChildPath.govtSalaryIncome, data: govtSalaryIncomeDataMap).then((result)async{
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
