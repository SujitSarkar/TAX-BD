import '../feature/home/model/home_data_model.dart';

class DummyData {
  static final List<HomeDataModel> homeDataList = [
    HomeDataModel(iconAsset: 'assets/home_icon/personal_info.svg', title: 'Personal Information'),
    HomeDataModel(iconAsset: 'assets/home_icon/income_info.svg', title: 'Income Information'),
    HomeDataModel(iconAsset: 'assets/home_icon/tax_calculation.svg', title: 'Tax Calculation'),
    HomeDataModel(iconAsset: 'assets/home_icon/investment.svg', title: 'Investment'),
    HomeDataModel(iconAsset: 'assets/home_icon/asset_info.svg', title: 'Asset Information'),
    HomeDataModel(iconAsset: 'assets/home_icon/expense.svg', title: 'Expense of Lifestyle'),
  ];

  static final List<HomeDataModel> incomeInfoDataList = [
    HomeDataModel(iconAsset: 'assets/income_icon/employment.svg', title: 'Income from Employment'),
    HomeDataModel(iconAsset: 'assets/income_icon/rent.svg', title: 'Income from Rent'),
    HomeDataModel(iconAsset: 'assets/income_icon/agriculture.svg', title: 'Income from Agriculture'),
    HomeDataModel(iconAsset: 'assets/income_icon/business.svg', title: 'Income from Business'),
    HomeDataModel(iconAsset: 'assets/income_icon/financial_asset.svg', title: 'Income from Financial Assets'),
    HomeDataModel(iconAsset: 'assets/income_icon/other_income.svg', title: 'Income from Other Sectors'),
    HomeDataModel(iconAsset: 'assets/income_icon/capital_gain.svg', title: 'Income from Capital Gain'),
    HomeDataModel(iconAsset: 'assets/income_icon/partnership_business.svg', title: 'Partnership Business Income'),
    HomeDataModel(iconAsset: 'assets/income_icon/foreign_income.svg', title: 'Foreign Income'),
    HomeDataModel(iconAsset: 'assets/income_icon/spouse_child_income.svg', title: 'Income of Spouse/Child')
  ];

  static const List<String> genderList = [
    "Man",
    "Women",
    "Others"
  ];

  static const List<String> incomeSourceLocationList = [
    "Dhaka North City Corporation",
    "Dhaka South City Corporation",
    "Chattogram City Corporation",
    "Other City Corporation",
    "Any Other Area"
  ];

  static const List<String> residentialStatusList = [
    "Resident",
    "Non-resident"
  ];
  static const List<String> statusOfTaxpayersList = [
    "Individual",
    "Firm",
    "Hindu undivided family",
    "Others",
    "None"
  ];
  static const List<String> taxpayerPrivilegesList = [
    "A gazette war-wounded freedom fighter",
    "Third gender",
    "Disable person",
    "Age 65 years or more",
    "A parent of a person with disability",
    "None"
  ];

  static const List<String> vehicleCCList = [
    "Up to 2500 CC",
    "Exceeding 2500 CC"
  ];
}
