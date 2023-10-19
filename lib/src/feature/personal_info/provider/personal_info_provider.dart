import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:tax_bd/src/constant/app_toast.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import '../../../constant/db_child_path.dart';
import '../../../constant/local_storage_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../../shared/local_storage.dart';
import '../../../shared/validator.dart';

class PersonalInfoProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> personalInfoFormKey = GlobalKey();
  String? genderRadioValue = DummyData.genderList.first;
  String? residentialStatusRadioValue = DummyData.residentialStatusList.first;
  String? statusOfTaxpayersRadioValue = DummyData.statusOfTaxpayersList.first;
  String? taxpayerPrivilegesRadioValue = DummyData.taxpayerPrivilegesList.last;
  DateTime dateOfBirth = DateTime.now();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nidOrPassportController = TextEditingController();
  final TextEditingController tinController = TextEditingController();
  final TextEditingController circleController = TextEditingController();
  final TextEditingController taxZoneController = TextEditingController();
  final TextEditingController assessmentYearController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
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

  void clearAllData(){
    nameController.clear();
    nidOrPassportController.clear();
    tinController.clear();
    circleController.clear();
    taxZoneController.clear();
    assessmentYearController.clear();
    dateOfBirthController.clear();
    spouseController.clear();
    spouseTinController.clear();
    contactAddressController.clear();
    telephoneController.clear();
    mobileController.clear();
    emailController.clear();
    currentlyWorkingOrgController.clear();
    orgNameController.clear();
    orgBinController.clear();
    partnerNameAndTinController.clear();

    loading = false;
    functionLoading = false;
  }

  ///UI interaction functions::::::::::::::::::::::::::::::::::::::::::::::::::
  void changeGender(String? newValue) {
    genderRadioValue = newValue;
    notifyListeners();
  }

  void changeResidentialStatus(String? newValue) {
    residentialStatusRadioValue = newValue;
    notifyListeners();
  }

  void changeClassOfTaxpayers(String? newValue) {
    statusOfTaxpayersRadioValue = newValue;
    notifyListeners();
  }

  void changeTaxpayerPrivileges(String? newValue) {
    taxpayerPrivilegesRadioValue = newValue;
    notifyListeners();
  }

  Future<void> selectDateOfBirth() async {
    dateOfBirth = await showDatePickerAndGetDate();
    dateOfBirthController.text = DateFormat('dd-MMM-yyyy').format(dateOfBirth);
    notifyListeners();
  }

  Future<void> getUserData() async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.personalInfo);

    if (data != null) {
      nameController.text = data['taxPayerName'];
      nidOrPassportController.text = data['taxPayerNid'];
      tinController.text = data['taxPayerTin'];
      circleController.text = data['circle'];
      taxZoneController.text = data['taxZone'];
      assessmentYearController.text = data['assessmentYear'];
      genderRadioValue = data['gender'];
      residentialStatusRadioValue = data['residentialStatus'] ?? 'None';
      statusOfTaxpayersRadioValue = data['statusOfTaxPayer'] ?? 'None';
      taxpayerPrivilegesRadioValue = data['privilegesOfTaxPayer'] ?? 'None';
      dateOfBirth = DateTime.fromMillisecondsSinceEpoch(data['dateOfBirth']);
      dateOfBirthController.text =
          DateFormat('dd-MMM-yyyy').format(dateOfBirth);
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
    }else{
      mobileController.text= userPhone!;
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
      'assessmentYear': assessmentYearController.text.trim(),
      'gender': genderRadioValue,
      'residentialStatus': residentialStatusRadioValue,
      'statusOfTaxPayer': statusOfTaxpayersRadioValue == 'None'
          ? null
          : statusOfTaxpayersRadioValue,
      'privilegesOfTaxPayer': taxpayerPrivilegesRadioValue == 'None'
          ? null
          : taxpayerPrivilegesRadioValue,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
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
