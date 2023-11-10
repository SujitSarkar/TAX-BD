import 'package:flutter/Material.dart';
import 'package:tax_bd/src/shared/app_navigator_key.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/app_toast.dart';

bool validateEmail(String emailAddress) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(emailAddress);

bool validatePassword(String password) => password.length >= 8;

bool isBullish(String sentiment) =>
    sentiment.toLowerCase().trim() == 'bullish' ||
    sentiment.toLowerCase().trim() == 'slightly bullish';

bool phoneValidator(String phone) => phone.length == 11;

bool otpValidator(String otp) => otp.length == 6;

Future<DateTime> showDatePickerAndGetDate() async {
  DateTime? selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
    context: AppNavigatorKey.key.currentState!.context,
    initialDate: selectedDate,
    firstDate: DateTime(1972),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return selectedDate;
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> launchPhone(String number) async {
  final String phoneNumber = "tel:$number";
  try {
    if (!await launchUrl(Uri.parse(phoneNumber))) {
      showToast('Could not make a call with $number');
    }
  } catch (error) {
    showToast(error.toString());
  }
}

Future<void> launchInWebView(String url) async {
  try {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      showToast('Could not launch $url');
    }
  } catch (error) {
    showToast(error.toString());
  }
}
