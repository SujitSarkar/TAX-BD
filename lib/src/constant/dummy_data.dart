import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../feature/home/model/home_data_model.dart';

class DummyData {
  static final List<HomeDataModel> homeDataList = [
    HomeDataModel(
        icon: LineAwesomeIcons.identification_card, title: 'Personal Information'),
    HomeDataModel(
        icon: LineAwesomeIcons.hand_holding_us_dollar, title: 'Income Information'),
    HomeDataModel(
        icon: LineAwesomeIcons.file_invoice_with_us_dollar, title: 'Tax Calculation'),
    HomeDataModel(icon: LineAwesomeIcons.percentage, title: 'Investment'),
    HomeDataModel(icon: LineAwesomeIcons.city, title: 'Asset Information'),
    HomeDataModel(icon: LineAwesomeIcons.coins, title: 'Expense of Lifestyle'),
  ];

  static final List<HomeDataModel> incomeInfoDataList = [
    HomeDataModel(icon: LineAwesomeIcons.user, title: 'Income from Employment'),
    HomeDataModel(icon: LineAwesomeIcons.home, title: 'Income from Rent'),
    HomeDataModel(icon: LineAwesomeIcons.tractor, title: 'Income from Agriculture'),
    HomeDataModel(icon: LineAwesomeIcons.briefcase, title: 'Income from Business'),
    HomeDataModel(
        icon: LineAwesomeIcons.recycle, title: 'Income from Financial Assets'),
    HomeDataModel(icon: LineAwesomeIcons.sitemap, title: 'Income from Other Sectors'),
    HomeDataModel(icon: LineAwesomeIcons.landmark, title: 'Income from Capital Gain'),
    HomeDataModel(
        icon: LineAwesomeIcons.hand_holding_us_dollar,
        title: 'Partnership Business Income'),
    HomeDataModel(icon: LineAwesomeIcons.globe, title: 'Foreign Income'),
    HomeDataModel(
        icon: LineAwesomeIcons.users, title: 'Income of Spouse/Child')
  ];

  static const List<String> genderList = [
    "Man",
    "Women",
    "Others"
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
  ]; //প্রতিবন্ধী ব্যক্তি
}
