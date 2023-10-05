import 'package:flutter/material.dart';
import '../../../constant/text_size.dart';

class GovtSalaryIncomeScreen extends StatelessWidget {
  const GovtSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'সরকারি বেতনভুক্ত',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
