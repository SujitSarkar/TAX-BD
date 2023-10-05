import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../feature/home/model/home_data_model.dart';

class DummyData {
  static final List<HomeDataModel> homeDataList = [
    HomeDataModel(
        icon: LineAwesomeIcons.identification_card, title: 'ব্যাক্তিগত তথ্য'),
    HomeDataModel(
        icon: LineAwesomeIcons.hand_holding_us_dollar, title: 'আয়ের তথ্য'),
    HomeDataModel(
        icon: LineAwesomeIcons.file_invoice_with_us_dollar, title: 'কর গননা'),
    HomeDataModel(icon: LineAwesomeIcons.percentage, title: 'রেয়াত হিসাব'),
    HomeDataModel(icon: LineAwesomeIcons.city, title: 'সম্পদের তথ্য'),
    HomeDataModel(icon: LineAwesomeIcons.coins, title: 'ব্যয় এর তথ্য'),
  ];

  static final List<HomeDataModel> incomeInfoDataList = [
    HomeDataModel(icon: LineAwesomeIcons.user, title: 'বেতন আয়'),
    HomeDataModel(icon: LineAwesomeIcons.home, title: 'ভাড়ার আয়'),
    HomeDataModel(icon: LineAwesomeIcons.tractor, title: 'কৃষি আয়'),
    HomeDataModel(icon: LineAwesomeIcons.briefcase, title: 'ব্যবসার আয়'),
    HomeDataModel(
        icon: LineAwesomeIcons.recycle, title: 'আর্থিক সম্পদ থেকে আয়'),
    HomeDataModel(icon: LineAwesomeIcons.sitemap, title: 'অন্যান্য খাতে আয়'),
    HomeDataModel(icon: LineAwesomeIcons.landmark, title: 'মুলধনী সম্পদের আয়'),
    HomeDataModel(
        icon: LineAwesomeIcons.hand_holding_us_dollar,
        title: 'অংশীদারি ব্যবসার আয়'),
    HomeDataModel(icon: LineAwesomeIcons.globe, title: 'বৈদেশী আয়'),
    HomeDataModel(
        icon: LineAwesomeIcons.users, title: 'স্বামী/স্ত্রী/সন্তানের আয়'),
  ];
}
