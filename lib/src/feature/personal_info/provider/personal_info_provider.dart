import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:tax_bd/src/constant/app_toast.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/feature/auth/repository/auth_repository.dart';
import 'package:tax_bd/src/shared/local_storage.dart';
import '../../../constant/local_storage_key.dart';

class PersonalInfoProvider extends ChangeNotifier {
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  bool loading = false;
  final GlobalKey<FormState> personalInfoFormKey = GlobalKey();
  String? residentialStatusRadioValue = DummyData.residentialStatusList.first;
  String? classOfTaxpayersRadioValue = DummyData.classOfTaxpayersList.first;
  String? taxpayerPrivilegesRadioValue = DummyData.taxpayerPrivilegesList.first;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nidOrPassportController = TextEditingController();
  final TextEditingController tinController = TextEditingController();
  final TextEditingController circleController = TextEditingController();
  final TextEditingController taxZoneController = TextEditingController();
  final TextEditingController taxYearController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController spouseController = TextEditingController();
  final TextEditingController spouseTinController = TextEditingController();
  final TextEditingController contactAddressController =
      TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentlyWorkingOrgController =
      TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController orgBinController = TextEditingController();
  final TextEditingController partnerNameAndTinController =
      TextEditingController();

  ///UI interaction functions::::::::::::::::::::::::::::::::::::::::::::::::::
  void changeResidentialStatus(String? newValue) {
    residentialStatusRadioValue = newValue;
    notifyListeners();
  }

  void changeClassOfTaxpayers(String? newValue) {
    classOfTaxpayersRadioValue = newValue;
    notifyListeners();
  }

  void changeTaxpayerPrivileges(String? newValue) {
    taxpayerPrivilegesRadioValue = newValue;
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final String? userId = await getData(LocalStorageKey.userIdKey);

    if (userPhone == null || userId == null) {
      await AuthRepository().logout();
      showToast('Invalid credential! Login again');
      return;
    }
    if (!personalInfoFormKey.currentState!.validate()) {
      return;
    }

    loading = true;
    notifyListeners();

    Map<String, dynamic> userDataMap = {
      'taxPayerName': nameController.text,
      'taxPayerNid': nidOrPassportController.text,
      'taxPayerTin': tinController.text,
      'circle': circleController.text,
      'taxZone': taxZoneController.text,
      'taxYear': taxYearController.text,
      'residentialStatus': residentialStatusRadioValue,
      'classOfTaxPayer': classOfTaxpayersRadioValue == 'None'
          ? null
          : classOfTaxpayersRadioValue,
      'privilegesOfTaxPayer': taxpayerPrivilegesRadioValue == 'None'
          ? null
          : taxpayerPrivilegesRadioValue,
      'dateOfBirth': dobController.text,
      'nameOfSpouse': spouseController.text,
      'tinOfSpouse': spouseTinController.text,
      'addressOfContact': contactAddressController.text,
      'telephone': telephoneController.text,
      'mobileNumber': mobileController.text,
      'emailAddress': emailController.text,
      'employedOrgName': currentlyWorkingOrgController.text,
      'organizationName': orgNameController.text,
      'binOfOrganization': orgBinController.text,
      'partnerNameAndTin': partnerNameAndTinController.text,
    };

    await _dbRef
        .child(userPhone)
        .child('personalInfo')
        .set(userDataMap)
        .then((_) {
      showToast('Data inserted successfully');
      loading = false;
      notifyListeners();
    }).catchError((error) {
      showToast('Error saving data');
      debugPrint('Error inserting data: $error');
      loading = false;
      notifyListeners();
    });
  }
}
