import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_toast.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import '../../../constant/db_child_path.dart';
import '../../../constant/local_storage_key.dart';
import '../../../shared/app_navigator_key.dart';
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
  String? statusOfTaxpayersDropdownValue = DummyData.statusOfTaxpayersList.first;
  String? taxpayerPrivilegesDropdownValue = DummyData.taxpayerPrivilegesList.last;
  String? taxpayerAreaDropdownValue = DummyData.areaList.first;
  DateTime dateOfBirth = DateTime.now();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nidOrPassportController = TextEditingController();
  final TextEditingController tinController = TextEditingController();
  final TextEditingController circleController = TextEditingController();
  final TextEditingController taxZoneController = TextEditingController();
  final TextEditingController assessmentYearController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController spouseController = TextEditingController();
  final TextEditingController spouseTinController = TextEditingController();
  final TextEditingController contactAddressController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentlyWorkingOrgController = TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController orgBinController = TextEditingController();
  final TextEditingController partnerNameAndTinController = TextEditingController();

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

  void changeStatusOfTaxpayers(String? newValue) {
    statusOfTaxpayersDropdownValue = newValue;
    notifyListeners();
  }

  void changeTaxpayerPrivileges(String? newValue) {
    taxpayerPrivilegesDropdownValue = newValue;
    notifyListeners();
  }

  void changeTaxpayerArea(String? newValue) {
    taxpayerAreaDropdownValue = newValue;
    notifyListeners();
  }

  Future<void> selectDateOfBirth() async {
    dateOfBirth = await showDatePickerAndGetDate();
    dateOfBirthController.text = DateFormat('dd MMM, yyyy').format(dateOfBirth);
    notifyListeners();
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> getUserData() async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final Map<String, dynamic>? data =
        await firebaseDbHelper.fetchData(childPath: DbChildPath.personalInfo);

    if (data != null) {
      nameController.text = data['taxPayerName'];
      nidOrPassportController.text = data['taxPayerNid'];
      tinController.text = data['taxPayerTin'];
      taxpayerAreaDropdownValue = data['taxPayerArea'];
      circleController.text = data['circle'];
      taxZoneController.text = data['taxZone'];
      assessmentYearController.text = data['assessmentYear'];
      genderRadioValue = data['gender'];
      residentialStatusRadioValue = data['residentialStatus'] ?? 'None';
      statusOfTaxpayersDropdownValue = data['statusOfTaxPayer'] ?? 'None';
      taxpayerPrivilegesDropdownValue = data['privilegesOfTaxPayer'] ?? 'None';
      dateOfBirth = DateTime.fromMillisecondsSinceEpoch(data['dateOfBirth']);
      dateOfBirthController.text = DateFormat('dd-MMM-yyyy').format(dateOfBirth);
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
    notifyListeners();
  }

  Future<void> submitDataButtonOnTap() async {
    if (!personalInfoFormKey.currentState!.validate()) {
      return;
    }
    final Map<String, dynamic> userDataMap = {
      'taxPayerName': nameController.text.trim(),
      'taxPayerNid': nidOrPassportController.text.trim(),
      'taxPayerTin': tinController.text.trim(),
      'taxPayerArea': taxpayerAreaDropdownValue,
      'circle': circleController.text.trim(),
      'taxZone': taxZoneController.text.trim(),
      'assessmentYear': assessmentYearController.text.trim(),
      'gender': genderRadioValue,
      'residentialStatus': residentialStatusRadioValue,
      'statusOfTaxPayer': statusOfTaxpayersDropdownValue == 'None'
          ? null
          : statusOfTaxpayersDropdownValue,
      'privilegesOfTaxPayer': taxpayerPrivilegesDropdownValue == 'None'
          ? null
          : taxpayerPrivilegesDropdownValue,
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
    await firebaseDbHelper.insertData(
        childPath: DbChildPath.personalInfo, data: userDataMap).then((result){
      if (result) {
        showToast('Success');
        TaxCalculationProvider taxCalculationProvider = Provider.of(
            AppNavigatorKey.key.currentState!.context, listen: false);
        taxCalculationProvider.getTaxCalculationData();
      } else {
        showToast('Failed');
      }
    });

    functionLoading = false;
    notifyListeners();
  }
}
