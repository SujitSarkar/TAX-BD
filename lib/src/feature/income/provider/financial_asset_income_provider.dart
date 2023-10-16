import 'package:flutter/Material.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/db_child_path.dart';
import '../../../shared/db_helper/firebase_db_helper.dart';
import '../model/financial_asset_income_input_model.dart';

class FinancialAssetIncomeProvider extends ChangeNotifier {
  final FirebaseDbHelper firebaseDbHelper = FirebaseDbHelper();
  bool loading = false;
  bool functionLoading = false;

  List<FDRIncomeItemModel> fdrIncomeItemList = [];
  List<DPSIncomeItemModel> dpsIncomeItemList = [];
  List<IncomeFromBankItemModel> incomeFromBankItemList = [];
  List<InsuranceProfitItemModel> insuranceProfitItemList = [];
  List<OthersProfitItemModel> othersProfitItemList = [];

  ///UI interaction functions::::::::::::::::::::::::::::::::::::::::::::::::::
  ///FDR
  void addFdrIncomeListItem() {
    fdrIncomeItemList.add(FDRIncomeItemModel(
        fdrNo: TextEditingController(),
        investmentFigure: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }
  Future<void> removeFdrIncomeListItem(int index) async{
    fdrIncomeItemList.removeAt(index);
    await submitFinancialAssetIncomeButtonOnTap();
    notifyListeners();
  }
  ///DPS
  void addDpsIncomeListItem() {
    dpsIncomeItemList.add(DPSIncomeItemModel(
        dpsNo: TextEditingController(),
        totalDepositAmount: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }
  Future<void> removeDpsIncomeListItem(int index) async{
    dpsIncomeItemList.removeAt(index);
    await submitFinancialAssetIncomeButtonOnTap();
    notifyListeners();
  }
  ///Bank
  void addIncomeFromBankListItem() {
    incomeFromBankItemList.add(IncomeFromBankItemModel(
        bankAccountNo: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }
  Future<void> removeIncomeFromBankListItem(int index) async{
    incomeFromBankItemList.removeAt(index);
    await submitFinancialAssetIncomeButtonOnTap();
    notifyListeners();
  }
  ///Insurance
  void addInsuranceProfitListItem() {
    insuranceProfitItemList.add(InsuranceProfitItemModel(
        insurancePolicyNo: TextEditingController(),
        premiumDeposit: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }
  Future<void> removeInsuranceProfitListItem(int index) async{
    insuranceProfitItemList.removeAt(index);
    await submitFinancialAssetIncomeButtonOnTap();
    notifyListeners();
  }
  ///Others
  void addOthersProfitListItem() {
    othersProfitItemList.add(OthersProfitItemModel(
        investmentDetails: TextEditingController(),
        amountOfInvestment: TextEditingController(),
        profitReceived: TextEditingController(),
        sourceTax: TextEditingController()));
    notifyListeners();
  }
  Future<void> removeOthersProfitListItem(int index) async{
    othersProfitItemList.removeAt(index);
    await submitFinancialAssetIncomeButtonOnTap();
    notifyListeners();
  }

  ///Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> getFinancialAssetIncomeData() async {
    fdrIncomeItemList = [];
    dpsIncomeItemList=[];
    incomeFromBankItemList=[];
    insuranceProfitItemList=[];
    othersProfitItemList=[];

    final Map<String, dynamic>? data =
    await firebaseDbHelper.fetchData(childPath: DbChildPath.financialAssetIncome);
    if (data != null) {
      //FDR data fetching
      if(data['fdrIncome'].isNotEmpty){
        for (var element in data['fdrIncome']) {
          fdrIncomeItemList.add(FDRIncomeItemModel(
              fdrNo: TextEditingController(text: element['fdrNo']),
              investmentFigure: TextEditingController(text: element['investmentFigure']),
              profitReceived: TextEditingController(text: element['profitReceived']),
              sourceTax: TextEditingController(text: element['sourceTax'])));
        }
      }else{
        fdrIncomeItemList.add(FDRIncomeItemModel(
            fdrNo: TextEditingController(),
            investmentFigure: TextEditingController(),
            profitReceived: TextEditingController(),
            sourceTax: TextEditingController()));
      }
      //DPS data fetching
      if(data['dpsIncome'].isNotEmpty){
        for (var element in data['dpsIncome']) {
          dpsIncomeItemList.add(DPSIncomeItemModel(
              dpsNo: TextEditingController(text: element['dpsNo']),
              totalDepositAmount: TextEditingController(text: element['totalDepositAmount']),
              profitReceived: TextEditingController(text: element['profitReceived']),
              sourceTax: TextEditingController(text: element['sourceTax'])));
        }
      }else{
        dpsIncomeItemList.add(DPSIncomeItemModel(
            dpsNo: TextEditingController(),
            totalDepositAmount: TextEditingController(),
            profitReceived: TextEditingController(),
            sourceTax: TextEditingController()));
      }
      //Bank data fetching
      if(data['incomeFromBank'].isNotEmpty){
        for (var element in data['incomeFromBank']) {
          incomeFromBankItemList.add(IncomeFromBankItemModel(
              bankAccountNo: TextEditingController(text: element['bankAccountNo']),
              profitReceived: TextEditingController(text: element['profitReceived']),
              sourceTax: TextEditingController(text: element['sourceTax'])));
        }
      }else{
        incomeFromBankItemList.add(IncomeFromBankItemModel(
            bankAccountNo: TextEditingController(),
            profitReceived: TextEditingController(),
            sourceTax: TextEditingController()));
      }
      //Insurance data fetching
      if(data['insuranceProfit'].isNotEmpty){
        for (var element in data['insuranceProfit']) {
          insuranceProfitItemList.add(InsuranceProfitItemModel(
              insurancePolicyNo: TextEditingController(text: element['insurancePolicyNo']),
              premiumDeposit: TextEditingController(text: element['premiumDeposit']),
              profitReceived: TextEditingController(text: element['profitReceived']),
              sourceTax: TextEditingController(text: element['sourceTax'])));
        }
      }else{
        insuranceProfitItemList.add(InsuranceProfitItemModel(
            insurancePolicyNo: TextEditingController(),
            premiumDeposit: TextEditingController(),
            profitReceived: TextEditingController(),
            sourceTax: TextEditingController()));
      }
      //Others data fetching
      if(data['othersProfit'].isNotEmpty){
        for (var element in data['othersProfit']) {
          othersProfitItemList.add(OthersProfitItemModel(
              investmentDetails: TextEditingController(text: element['investmentDetails']),
              amountOfInvestment: TextEditingController(text: element['amountOfInvestment']),
              profitReceived: TextEditingController(text: element['profitReceived']),
              sourceTax: TextEditingController(text: element['sourceTax'])));
        }
      }else{
        othersProfitItemList.add(OthersProfitItemModel(
            investmentDetails: TextEditingController(),
            amountOfInvestment: TextEditingController(),
            profitReceived: TextEditingController(),
            sourceTax: TextEditingController()));
      }

    } else {
      fdrIncomeItemList.add(FDRIncomeItemModel(
          fdrNo: TextEditingController(),
          investmentFigure: TextEditingController(),
          profitReceived: TextEditingController(),
          sourceTax: TextEditingController()));
      dpsIncomeItemList.add(DPSIncomeItemModel(
          dpsNo: TextEditingController(),
          totalDepositAmount: TextEditingController(),
          profitReceived: TextEditingController(),
          sourceTax: TextEditingController()));
      incomeFromBankItemList.add(IncomeFromBankItemModel(
          bankAccountNo: TextEditingController(),
          profitReceived: TextEditingController(),
          sourceTax: TextEditingController()));
      insuranceProfitItemList.add(InsuranceProfitItemModel(
          insurancePolicyNo: TextEditingController(),
          premiumDeposit: TextEditingController(),
          profitReceived: TextEditingController(),
          sourceTax: TextEditingController()));
      othersProfitItemList.add(OthersProfitItemModel(
          investmentDetails: TextEditingController(),
          amountOfInvestment: TextEditingController(),
          profitReceived: TextEditingController(),
          sourceTax: TextEditingController()));
    }
    notifyListeners();
  }

  Future<void> submitFinancialAssetIncomeButtonOnTap() async {
    functionLoading = true;
    notifyListeners();
    final List<Map<String, dynamic>> fdrDataList = [];
    final List<Map<String, dynamic>> dpsDataList = [];
    final List<Map<String, dynamic>> bankDataList = [];
    final List<Map<String, dynamic>> insuranceDataList = [];
    final List<Map<String, dynamic>> othersDataList = [];

    ///FDR
    for (FDRIncomeItemModel element in fdrIncomeItemList) {
      final Map<String, dynamic> fdrDataMap = {
        'fdrNo': element.fdrNo!.text.trim(),
        'investmentFigure': element.investmentFigure!.text.trim(),
        'profitReceived': element.profitReceived!.text.trim(),
        'sourceTax': element.sourceTax!.text.trim(),
      };
      fdrDataList.add(fdrDataMap);
    }
    ///DPS
    for (DPSIncomeItemModel element in dpsIncomeItemList) {
      final Map<String, dynamic> dpsDataMap = {
        'dpsNo': element.dpsNo!.text.trim(),
        'totalDepositAmount': element.totalDepositAmount!.text.trim(),
        'profitReceived': element.profitReceived!.text.trim(),
        'sourceTax': element.sourceTax!.text.trim(),
      };
      dpsDataList.add(dpsDataMap);
    }
    ///Bank
    for (IncomeFromBankItemModel element in incomeFromBankItemList) {
      final Map<String, dynamic> bankDataMap = {
        'bankAccountNo': element.bankAccountNo!.text.trim(),
        'profitReceived': element.profitReceived!.text.trim(),
        'sourceTax': element.sourceTax!.text.trim(),
      };
      bankDataList.add(bankDataMap);
    }
    ///Insurance
    for (InsuranceProfitItemModel element in insuranceProfitItemList) {
      final Map<String, dynamic> insuranceDataMap = {
        'insurancePolicyNo': element.insurancePolicyNo!.text.trim(),
        'premiumDeposit': element.premiumDeposit!.text.trim(),
        'profitReceived': element.profitReceived!.text.trim(),
        'sourceTax': element.sourceTax!.text.trim(),
      };
      insuranceDataList.add(insuranceDataMap);
    }
    ///Others
    for (OthersProfitItemModel element in othersProfitItemList) {
      final Map<String, dynamic> othersDataMap = {
        'investmentDetails': element.investmentDetails!.text.trim(),
        'amountOfInvestment': element.amountOfInvestment!.text.trim(),
        'profitReceived': element.profitReceived!.text.trim(),
        'sourceTax': element.sourceTax!.text.trim(),
      };
      othersDataList.add(othersDataMap);
    }

    final Map<String, dynamic> financialAssetIncomeDataMap = {
      'fdrIncome': fdrDataList,
      'dpsIncome': dpsDataList,
      'incomeFromBank': bankDataList,
      'insuranceProfit': insuranceDataList,
      'othersProfit': othersDataList,
    };

    final bool result = await firebaseDbHelper.insertData(
        childPath: DbChildPath.financialAssetIncome, data: financialAssetIncomeDataMap);
    if (result) {
      showToast('Success');
    } else {
      showToast('Failed');
    }
    functionLoading = false;
    notifyListeners();
  }
}
