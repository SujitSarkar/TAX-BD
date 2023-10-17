import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/asset/model/asset_info_input_model.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';

class AssetInfoProvider extends ChangeNotifier{
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  AssetInfoInputModel assetInfoInputModel = AssetInfoInputModel();

  Future<void> getAssetInfoData() async {
    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.assetInfo);

    // if (data != null) {
    //   nameController.text = data['taxPayerName'];
    //   nidOrPassportController.text = data['taxPayerNid'];
    //   tinController.text = data['taxPayerTin'];
    //   circleController.text = data['circle'];
    //   taxZoneController.text = data['taxZone'];
    //   assessmentYearController.text = data['assessmentYear'];
    //   genderRadioValue= data['gender'];
    //   residentialStatusRadioValue = data['residentialStatus'] ?? 'None';
    //   statusOfTaxpayersRadioValue = data['statusOfTaxPayer'] ?? 'None';
    //   taxpayerPrivilegesRadioValue = data['privilegesOfTaxPayer'] ?? 'None';
    //   dateOfBirth = DateTime.fromMillisecondsSinceEpoch(data['dateOfBirth']);
    //   dateOfBirthController.text = DateFormat('dd-MMM-yyyy').format(dateOfBirth);
    //   spouseController.text = data['nameOfSpouse'];
    //   spouseTinController.text = data['tinOfSpouse'];
    //   contactAddressController.text = data['addressOfContact'];
    //   telephoneController.text = data['telephone'];
    //   mobileController.text = data['mobileNumber'];
    //   emailController.text = data['emailAddress'];
    //   currentlyWorkingOrgController.text = data['employedOrgName'];
    //   orgNameController.text = data['organizationName'];
    //   orgBinController.text = data['binOfOrganization'];
    //   partnerNameAndTinController.text = data['partnerNameAndTin'];
    // }
    // notifyListeners();
  }
}