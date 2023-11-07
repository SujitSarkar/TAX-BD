import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../../../shared/validator.dart';
import '../../asset/provider/asset_info_provider.dart';
import '../../tax/provider/tax_calculation_provider.dart';
import '../model/capital_gain_income_input_model.dart';

class CapitalGainIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;
  final GlobalKey<FormState> capitalGainKey = GlobalKey();
  List<CapitalGainIncomeInputModel> capitalGainIncomeInputList = [];

  void clearAllData() {
    capitalGainIncomeInputList = [];
    loading = false;
    functionLoading = false;
  }

  ///UI Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> selectDateOfDeed(int index) async {
    capitalGainIncomeInputList[index].dateOfDeed =
    await showDatePickerAndGetDate();
    capitalGainIncomeInputList[index].dateOfDeedText!.text =
        DateFormat('dd-MMM-yyyy')
            .format(capitalGainIncomeInputList[index].dateOfDeed!);
    notifyListeners();
  }

  Future<void> selectAcquisitionDate(int index) async {
    capitalGainIncomeInputList[index].acquisitionDate =
        await showDatePickerAndGetDate();
    capitalGainIncomeInputList[index].acquisitionDateText!.text =
        DateFormat('dd-MMM-yyyy')
            .format(capitalGainIncomeInputList[index].acquisitionDate!);
    notifyListeners();
  }

  Future<void> selectSalesDate(int index) async {
    capitalGainIncomeInputList[index].salesDate =
        await showDatePickerAndGetDate();
    capitalGainIncomeInputList[index].salesDateText!.text =
        DateFormat('dd-MMM-yyyy')
            .format(capitalGainIncomeInputList[index].salesDate!);
    notifyListeners();
  }

  void changeTypeOfGains(int index, String? newValue) {
    capitalGainIncomeInputList[index].typeOfGains = newValue;

    ///Clear previous data
    capitalGainIncomeInputList[index].description!.clear();
    capitalGainIncomeInputList[index].area!.clear();
    capitalGainIncomeInputList[index].tinOfBuyer!.clear();
    capitalGainIncomeInputList[index].deedNo!.clear();
    capitalGainIncomeInputList[index].subRegistrarOffice!.clear();
    capitalGainIncomeInputList[index].saleDeedValue!.clear();
    capitalGainIncomeInputList[index].costOfAcquisition!.clear();
    capitalGainIncomeInputList[index].capitalGain!.clear();
    capitalGainIncomeInputList[index].taxDeductedCollectedAtSource!.clear();
    capitalGainIncomeInputList[index].flatBuildingArea!.clear();
    capitalGainIncomeInputList[index].salesValue!.clear();
    capitalGainIncomeInputList[index].costOfSales!.clear();
    notifyListeners();
  }

  void changeAreaUnit(int index, String? newValue) {
    capitalGainIncomeInputList[index].areaUnit = newValue;
    notifyListeners();
  }
  void changeFlatBuildingUnit(int index, String? newValue) {
    capitalGainIncomeInputList[index].flatBuildingUnit = newValue;
    notifyListeners();
  }

  ///Functions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void addCapitalGainInputListItem() {
    capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
      typeOfGains: DummyData.capitalGainCategoryList.first,
      description: TextEditingController(),
      area: TextEditingController(),
      areaUnit: DummyData.areaUnitList.first,
      tinOfBuyer: TextEditingController(),
      deedNo: TextEditingController(),
      dateOfDeed: DateTime.now(),
      dateOfDeedText: TextEditingController(),
      subRegistrarOffice: TextEditingController(),
      saleDeedValue: TextEditingController(),
      costOfAcquisition: TextEditingController(),
      capitalGain: TextEditingController(),
      taxDeductedCollectedAtSource: TextEditingController(),
      ///House/Apartment
      flatBuildingArea: TextEditingController(),
      flatBuildingUnit: DummyData.buildingUnitList.first,
      ///Other Capital Gain
      acquisitionDate: DateTime.now(),
      acquisitionDateText:TextEditingController(),
      salesDate: DateTime.now(),
      salesDateText: TextEditingController(),
      salesValue: TextEditingController(),
      costOfSales: TextEditingController(),
    ));
    notifyListeners();
  }

  void removeItemOfCapitalGainIncomeInputList(int index) async {
    capitalGainIncomeInputList.removeAt(index);
    await submitCapitalGainIncomeButtonOnTap();
    notifyListeners();
  }

  Future<void> getCapitalGainIncomeData() async {
    capitalGainIncomeInputList = [];
    final Map<String, dynamic>? data = await firebaseDbHelper.fetchData(
        childPath: DbChildPath.capitalGainIncome);

    if (data != null) {
      if (data['data'] != null && data['data'].isNotEmpty) {
        for (var element in data['data']) {
          capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
            typeOfGains: element['typeOfGains'],
            description: TextEditingController(text: element['description']),
            area: TextEditingController(text: element['area']),
            areaUnit: element['areaUnit'],
            tinOfBuyer: TextEditingController(text: element['tinOfBuyer']),
            deedNo: TextEditingController(text: element['deedNo']),
            dateOfDeed: DateTime.fromMillisecondsSinceEpoch(element['dateOfDeed']),
            dateOfDeedText: TextEditingController(text: DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['dateOfDeed']))),
            subRegistrarOffice: TextEditingController(text: element['subRegistrarOffice']),
            saleDeedValue: TextEditingController(text: element['saleDeedValue']),
            costOfAcquisition: TextEditingController(text: element['costOfAcquisition']),
            capitalGain: TextEditingController(text: element['capitalGain']),
            taxDeductedCollectedAtSource: TextEditingController(text: element['taxDeductedCollectedAtSource']),
            ///House/Apartment
            flatBuildingArea: TextEditingController(text: element['flatBuildingArea']),
            flatBuildingUnit: element['flatBuildingUnit'],
            ///Other Capital Gain
            acquisitionDate: DateTime.fromMillisecondsSinceEpoch(element['acquisitionDate']),
            acquisitionDateText: TextEditingController(text: DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['acquisitionDate']))),
            salesDate: DateTime.fromMillisecondsSinceEpoch(element['salesDate']),
            salesDateText: TextEditingController(text: DateFormat('dd-MMM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['salesDate']))),
            salesValue: TextEditingController(text: element['salesValue']),
            costOfSales: TextEditingController(text: element['costOfSales']),
          ));
        }
      }
    } else {
      capitalGainIncomeInputList.add(CapitalGainIncomeInputModel(
        typeOfGains: DummyData.capitalGainCategoryList.first,
        description: TextEditingController(),
        area: TextEditingController(),
        areaUnit: DummyData.areaUnitList.first,
        tinOfBuyer: TextEditingController(),
        deedNo: TextEditingController(),
        dateOfDeed: DateTime.now(),
        dateOfDeedText: TextEditingController(),
        subRegistrarOffice: TextEditingController(),
        saleDeedValue: TextEditingController(),
        costOfAcquisition: TextEditingController(),
        capitalGain: TextEditingController(),
        taxDeductedCollectedAtSource: TextEditingController(),
        ///House/Apartment
        flatBuildingArea: TextEditingController(),
        flatBuildingUnit: DummyData.buildingUnitList.first,
        ///Other Capital Gain
        acquisitionDate: DateTime.now(),
        acquisitionDateText:TextEditingController(),
        salesDate: DateTime.now(),
        salesDateText: TextEditingController(),
        salesValue: TextEditingController(),
        costOfSales: TextEditingController(),
      ));
    }
    notifyListeners();
  }

  Future<void> submitCapitalGainIncomeButtonOnTap() async {
    if (!capitalGainKey.currentState!.validate()) {
      return;
    }
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> capitalGainIncomeDataList = [];

    for (CapitalGainIncomeInputModel element in capitalGainIncomeInputList) {
      double capitalGainValue = 0.0;

      if(element.typeOfGains == DummyData.capitalGainCategoryList.first ||
          element.typeOfGains == DummyData.capitalGainCategoryList[1]){

        capitalGainValue = double.parse(
            element.saleDeedValue!.text.isEmpty
                ? '0.0'
                : element.saleDeedValue!.text.trim()) -
            double.parse(element.costOfAcquisition!.text.isEmpty
                ? '0.0'
                : element.costOfAcquisition!.text.trim());
      }
      else if(element.typeOfGains == DummyData.capitalGainCategoryList.last){
        capitalGainValue = double.parse(
            element.salesValue!.text.isEmpty
                ? '0.0'
                : element.salesValue!.text.trim()) -
            double.parse(element.costOfAcquisition!.text.isEmpty
                ? '0.0'
                : element.costOfAcquisition!.text.trim()) -
            double.parse(element.costOfSales!.text.isEmpty
            ? '0.0'
            : element.costOfSales!.text.trim());
      }
      element.capitalGain!.text = '$capitalGainValue';
      notifyListeners();

      final Map<String, dynamic> dataMap = {
        'typeOfGains': element.typeOfGains,
        'description': element.description!.text.trim(),
        'area': element.area!.text.trim(),
        'areaUnit': element.areaUnit,
        'tinOfBuyer': element.tinOfBuyer!.text.trim(),
        'deedNo': element.deedNo!.text.trim(),
        'dateOfDeed':element.dateOfDeed!.millisecondsSinceEpoch,
        'subRegistrarOffice': element.subRegistrarOffice!.text.trim(),
        'saleDeedValue': element.saleDeedValue!.text.trim(),
        'costOfAcquisition': element.costOfAcquisition!.text.trim(),
        'capitalGain': element.capitalGain!.text.trim(),
        'taxDeductedCollectedAtSource': element.taxDeductedCollectedAtSource!.text.trim(),
        'flatBuildingArea': element.flatBuildingArea!.text.trim(),
        'flatBuildingUnit': element.flatBuildingUnit,
        'acquisitionDate':element.acquisitionDate!.millisecondsSinceEpoch,
        'salesDate': element.salesDate!.millisecondsSinceEpoch,
        'salesValue': element.salesValue!.text.trim(),
        'costOfSales': element.costOfSales!.text.trim(),
      };
      capitalGainIncomeDataList.add(dataMap);
    }
    final Map<String, dynamic> capitalGainIncomeDataMap = {
      'data': capitalGainIncomeDataList
    };

    firebaseDbHelper.insertData(
            childPath: DbChildPath.capitalGainIncome,
            data: capitalGainIncomeDataMap)
        .then((result) async {
      if (result) {
        TaxCalculationProvider taxCalculationProvider = Provider.of(
            AppNavigatorKey.key.currentState!.context,
            listen: false);
        AssetInfoProvider assetInfoProvider = Provider.of(
            AppNavigatorKey.key.currentState!.context,
            listen: false);
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
