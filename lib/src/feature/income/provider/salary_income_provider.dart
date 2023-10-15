import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/model/private_salary_income_input_model.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/govt_salary_income_input_model.dart';

class SalaryIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<PrivateSalaryIncomeInputModel> privateSalaryIncomeInputList = [];

  List<GovtSalaryIncomeInputModel> govtSalaryIncomeInputList = [];

  ///UI Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  ///Private Salary
  void addPrivateSalaryIncomeInputListItem() {
    privateSalaryIncomeInputList.add(
      PrivateSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        allowance: TextEditingController(),
        advanceSalary: TextEditingController(),
        gratuityAnnuity: TextEditingController(),
        perquisites: TextEditingController(),
        additionalSalaryOrWages: TextEditingController(),
        shareScheme: TextEditingController(),
        accommodationFacility: TextEditingController(),
        transportFacility: TextEditingController(),
        anyOtherFacility: TextEditingController(),
        providentFund: TextEditingController(),
        others: TextEditingController(),
        totalSalaryReceived: TextEditingController(),
        exemptedAmount: TextEditingController(),
        totalIncomeFromSalary: TextEditingController(),
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
              basicPay: TextEditingController(text: element['basicPay']),
              allowance: TextEditingController(text: element['allowance']),
              advanceSalary:
                  TextEditingController(text: element['advanceSalary']),
              gratuityAnnuity:
                  TextEditingController(text: element['gratuityAnnuity']),
              perquisites: TextEditingController(text: element['perquisites']),
              additionalSalaryOrWages: TextEditingController(
                  text: element['additionalSalaryOrWages']),
              shareScheme: TextEditingController(text: element['shareScheme']),
              accommodationFacility:
                  TextEditingController(text: element['accommodationFacility']),
              transportFacility:
                  TextEditingController(text: element['transportFacility']),
              anyOtherFacility:
                  TextEditingController(text: element['anyOtherFacility']),
              providentFund:
                  TextEditingController(text: element['providentFund']),
              others: TextEditingController(text: element['others']),
              totalSalaryReceived:
                  TextEditingController(text: element['totalSalaryReceived']),
              exemptedAmount:
                  TextEditingController(text: element['exemptedAmount']),
              totalIncomeFromSalary:
                  TextEditingController(text: element['totalIncomeFromSalary']),
            ),
          );
        }
      }
    } else {
      privateSalaryIncomeInputList.add(
        PrivateSalaryIncomeInputModel(
          basicPay: TextEditingController(),
          allowance: TextEditingController(),
          advanceSalary: TextEditingController(),
          gratuityAnnuity: TextEditingController(),
          perquisites: TextEditingController(),
          additionalSalaryOrWages: TextEditingController(),
          shareScheme: TextEditingController(),
          accommodationFacility: TextEditingController(),
          transportFacility: TextEditingController(),
          anyOtherFacility: TextEditingController(),
          providentFund: TextEditingController(),
          others: TextEditingController(),
          totalSalaryReceived: TextEditingController(),
          exemptedAmount: TextEditingController(),
          totalIncomeFromSalary: TextEditingController(),
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
      final double totalSalaryReceivedValue = double.parse(
              element.basicPay!.text.isEmpty
                  ? '0.0'
                  : element.basicPay!.text.trim()) +
          double.parse(element.allowance!.text.isEmpty
              ? '0.0'
              : element.allowance!.text.trim()) +
          double.parse(element.advanceSalary!.text.isEmpty
              ? '0.0'
              : element.advanceSalary!.text.trim()) +
          double.parse(element.gratuityAnnuity!.text.isEmpty
              ? '0.0'
              : element.gratuityAnnuity!.text.trim()) +
          double.parse(element.perquisites!.text.isEmpty
              ? '0.0'
              : element.perquisites!.text.trim()) +
          double.parse(element.additionalSalaryOrWages!.text.isEmpty
              ? '0.0'
              : element.additionalSalaryOrWages!.text.trim()) +
          double.parse(element.shareScheme!.text.isEmpty
              ? '0.0'
              : element.shareScheme!.text.trim()) +
          double.parse(element.accommodationFacility!.text.isEmpty
              ? '0.0'
              : element.accommodationFacility!.text.trim()) +
          double.parse(element.transportFacility!.text.isEmpty
              ? '0.0'
              : element.transportFacility!.text.trim()) +
          double.parse(element.anyOtherFacility!.text.isEmpty
              ? '0.0'
              : element.anyOtherFacility!.text.trim()) +
          double.parse(element.providentFund!.text.isEmpty
              ? '0.0'
              : element.providentFund!.text.trim()) +
          double.parse(element.others!.text.isEmpty ? '0.0' : element.others!.text.trim());

      final double totalIncomeFromSalaryValue = totalSalaryReceivedValue -
          double.parse(element.exemptedAmount!.text.isEmpty
              ? '0.0'
              : element.exemptedAmount!.text.trim());

      element.totalSalaryReceived!.text = '$totalSalaryReceivedValue';
      element.totalIncomeFromSalary!.text = '$totalIncomeFromSalaryValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'basicPay': element.basicPay!.text,
        'allowance': element.allowance!.text,
        'advanceSalary': element.advanceSalary!.text,
        'gratuityAnnuity': element.gratuityAnnuity!.text,
        'perquisites': element.perquisites!.text,
        'additionalSalaryOrWages': element.additionalSalaryOrWages!.text,
        'shareScheme': element.shareScheme!.text,
        'accommodationFacility': element.accommodationFacility!.text,
        'transportFacility': element.transportFacility!.text,
        'anyOtherFacility': element.anyOtherFacility!.text,
        'providentFund': element.providentFund!.text,
        'others': element.others!.text,
        'totalSalaryReceived': element.totalSalaryReceived!.text,
        'exemptedAmount': element.exemptedAmount!.text,
        'totalIncomeFromSalary': element.totalIncomeFromSalary!.text,
      };
      privateSalaryIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> privateSalaryIncomeDataMap = {
      'data': privateSalaryIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.privateSalaryIncome,
        data: privateSalaryIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }



  ///Govt Salary
  void addGovtSalaryIncomeInputListItem() {
    govtSalaryIncomeInputList.add(
      GovtSalaryIncomeInputModel(
        basicPay: TextEditingController(),
        arrearPay: TextEditingController(),
        specialAllowance: TextEditingController(),
        houseRentAllowance: TextEditingController(),
        medicalAllowance: TextEditingController(),
        conveyanceAllowance: TextEditingController(),
        festivalAllowance: TextEditingController(),
        supportStaffAllowance: TextEditingController(),
        leaveAllowance: TextEditingController(),
        honorariumReward: TextEditingController(),
        overtimeAllowances: TextEditingController(),
        banglaNoboborshoAllowances: TextEditingController(),
        interestAccruedOnProvidentFund: TextEditingController(),
        lumpGrant: TextEditingController(),
        gratuity: TextEditingController(),
        others: TextEditingController(),
        total: TextEditingController(),
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
              basicPay: TextEditingController(text: element['basicPay']),
              arrearPay: TextEditingController(text: element['arrearPay']),
              specialAllowance:
                  TextEditingController(text: element['specialAllowance']),
              houseRentAllowance:
                  TextEditingController(text: element['houseRentAllowance']),
              medicalAllowance:
                  TextEditingController(text: element['medicalAllowance']),
              conveyanceAllowance:
                  TextEditingController(text: element['conveyanceAllowance']),
              festivalAllowance:
                  TextEditingController(text: element['festivalAllowance']),
              supportStaffAllowance:
                  TextEditingController(text: element['supportStaffAllowance']),
              leaveAllowance:
                  TextEditingController(text: element['leaveAllowance']),
              honorariumReward:
                  TextEditingController(text: element['honorariumReward']),
              overtimeAllowances:
                  TextEditingController(text: element['overtimeAllowances']),
              banglaNoboborshoAllowances: TextEditingController(
                  text: element['banglaNoboborshoAllowances']),
              interestAccruedOnProvidentFund: TextEditingController(
                  text: element['interestAccruedOnProvidentFund']),
              lumpGrant: TextEditingController(text: element['lumpGrant']),
              gratuity: TextEditingController(text: element['gratuity']),
              others: TextEditingController(text: element['others']),
              total: TextEditingController(text: element['total']),
            ),
          );
        }
      }
    } else {
      govtSalaryIncomeInputList.add(
        GovtSalaryIncomeInputModel(
          basicPay: TextEditingController(),
          arrearPay: TextEditingController(),
          specialAllowance: TextEditingController(),
          houseRentAllowance: TextEditingController(),
          medicalAllowance: TextEditingController(),
          conveyanceAllowance: TextEditingController(),
          festivalAllowance: TextEditingController(),
          supportStaffAllowance: TextEditingController(),
          leaveAllowance: TextEditingController(),
          honorariumReward: TextEditingController(),
          overtimeAllowances: TextEditingController(),
          banglaNoboborshoAllowances: TextEditingController(),
          interestAccruedOnProvidentFund: TextEditingController(),
          lumpGrant: TextEditingController(),
          gratuity: TextEditingController(),
          others: TextEditingController(),
          total: TextEditingController(),
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
      final double totalValue = double.parse(element.basicPay!.text.isEmpty
              ? '0.0'
              : element.basicPay!.text.trim()) +
          double.parse(element.arrearPay!.text.isEmpty
              ? '0.0'
              : element.arrearPay!.text.trim()) +
          double.parse(element.specialAllowance!.text.isEmpty
              ? '0.0'
              : element.specialAllowance!.text.trim()) +
          double.parse(element.houseRentAllowance!.text.isEmpty
              ? '0.0'
              : element.houseRentAllowance!.text.trim()) +
          double.parse(element.medicalAllowance!.text.isEmpty
              ? '0.0'
              : element.medicalAllowance!.text.trim()) +
          double.parse(element.conveyanceAllowance!.text.isEmpty
              ? '0.0'
              : element.conveyanceAllowance!.text.trim()) +
          double.parse(element.festivalAllowance!.text.isEmpty
              ? '0.0'
              : element.festivalAllowance!.text.trim()) +
          double.parse(element.supportStaffAllowance!.text.isEmpty
              ? '0.0'
              : element.supportStaffAllowance!.text.trim()) +
          double.parse(element.leaveAllowance!.text.isEmpty
              ? '0.0'
              : element.leaveAllowance!.text.trim()) +
          double.parse(element.honorariumReward!.text.isEmpty
              ? '0.0'
              : element.honorariumReward!.text.trim()) +
          double.parse(element.overtimeAllowances!.text.isEmpty
              ? '0.0'
              : element.overtimeAllowances!.text.trim()) +
          double.parse(element.banglaNoboborshoAllowances!.text.isEmpty
              ? '0.0'
              : element.banglaNoboborshoAllowances!.text.trim()) +
          double.parse(element.interestAccruedOnProvidentFund!.text.isEmpty
              ? '0.0'
              : element.interestAccruedOnProvidentFund!.text.trim()) +
          double.parse(element.lumpGrant!.text.isEmpty
              ? '0.0'
              : element.lumpGrant!.text.trim()) +
          double.parse(element.gratuity!.text.isEmpty
              ? '0.0'
              : element.gratuity!.text.trim()) +
          double.parse(element.others!.text.isEmpty
              ? '0.0'
              : element.others!.text.trim());

      element.total!.text = '$totalValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'basicPay': element.basicPay!.text,
        'arrearPay': element.arrearPay!.text,
        'specialAllowance': element.specialAllowance!.text,
        'houseRentAllowance': element.houseRentAllowance!.text,
        'medicalAllowance': element.medicalAllowance!.text,
        'conveyanceAllowance': element.conveyanceAllowance!.text,
        'festivalAllowance': element.festivalAllowance!.text,
        'supportStaffAllowance': element.supportStaffAllowance!.text,
        'leaveAllowance': element.leaveAllowance!.text,
        'honorariumReward': element.honorariumReward!.text,
        'overtimeAllowances': element.overtimeAllowances!.text,
        'banglaNoboborshoAllowances': element.banglaNoboborshoAllowances!.text,
        'interestAccruedOnProvidentFund':
            element.interestAccruedOnProvidentFund!.text,
        'lumpGrant': element.lumpGrant!.text,
        'gratuity': element.gratuity!.text,
        'others': element.others!.text,
        'total': element.total!.text,
      };
      govtSalaryIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> govtSalaryIncomeDataMap = {
      'data': govtSalaryIncomeDataList
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.govtSalaryIncome, data: govtSalaryIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
