import 'package:flutter/Material.dart';
import 'package:tax_bd/src/constant/app_toast.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';

class PersonalInfoProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
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

  Future<void> getUserData() async {
    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.personalInfo);

    if (data != null) {
      nameController.text = data['taxPayerName'];
      nidOrPassportController.text = data['taxPayerNid'];
      tinController.text = data['taxPayerTin'];
      circleController.text = data['circle'];
      taxZoneController.text = data['taxZone'];
      taxYearController.text = data['taxYear'];
      residentialStatusRadioValue = data['residentialStatus'] ?? 'None';
      classOfTaxpayersRadioValue = data['classOfTaxPayer'] ?? 'None';
      taxpayerPrivilegesRadioValue = data['privilegesOfTaxPayer'] ??
          'None';
      dobController.text = data['dateOfBirth'];
      spouseController.text = data['nameOfSpouse'];
      spouseTinController.text = data['tinOfSpouse'];
      contactAddressController.text = data['addressOfContact'];
      telephoneController.text = data['telephone'];
      mobileController.text = data['mobileNumber'];
      emailController.text = data['emailAddress'];
      currentlyWorkingOrgController.text = data['employedOrgName'];
      orgNameController.text = data['organizationName'];
      orgBinController.text = data['binOfOrganization'];
      partnerNameAndTinController.text = data['partnerNameAndTin'];
    }
    // notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    if (!personalInfoFormKey.currentState!.validate()) {
      return;
    }
    final Map<String, dynamic> userDataMap = {
      'taxPayerName': nameController.text.trim(),
      'taxPayerNid': nidOrPassportController.text.trim(),
      'taxPayerTin': tinController.text.trim(),
      'circle': circleController.text.trim(),
      'taxZone': taxZoneController.text.trim(),
      'taxYear': taxYearController.text.trim(),
      'residentialStatus': residentialStatusRadioValue,
      'classOfTaxPayer': classOfTaxpayersRadioValue == 'None'
          ? null
          : classOfTaxpayersRadioValue,
      'privilegesOfTaxPayer': taxpayerPrivilegesRadioValue == 'None'
          ? null
          : taxpayerPrivilegesRadioValue,
      'dateOfBirth': dobController.text.trim(),
      'nameOfSpouse': spouseController.text.trim(),
      'tinOfSpouse': spouseTinController.text.trim(),
      'addressOfContact': contactAddressController.text.trim(),
      'telephone': telephoneController.text.trim(),
      'mobileNumber': mobileController.text.trim(),
      'emailAddress': emailController.text.trim(),
      'employedOrgName': currentlyWorkingOrgController.text.trim(),
      'organizationName': orgNameController.text.trim(),
      'binOfOrganization': orgBinController.text.trim(),
      'partnerNameAndTin': partnerNameAndTinController.text.trim(),
    };
    functionLoading = true;
    notifyListeners();
    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.personalInfo, data: userDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
