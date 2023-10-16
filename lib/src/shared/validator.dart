import 'package:flutter/Material.dart';
import 'package:tax_bd/src/shared/app_navigator_key.dart';

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