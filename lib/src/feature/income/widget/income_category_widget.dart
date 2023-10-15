import 'package:flutter/material.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/app_color.dart';
import '../../../constant/text_size.dart';

class IncomeCategoryWidget extends StatelessWidget {
  const IncomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .4,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: const BoxDecoration(
          color: AppColor.appBodyBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(children: [
        const Text(
          'Salary Information',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
        const Divider(thickness: 1),
        const SizedBox(height: 40),
        SolidButton(
            onTap: () {
              Navigator.popAndPushNamed(
                  context, AppRouter.govtSalaryIncomeScreen);
            },
            child: const Text(
              'Govt. Salary Income',
              style: TextStyle(fontSize: TextSize.titleText),
            )),
        const SizedBox(height: 20),
        SolidButton(
            onTap: () {
              Navigator.popAndPushNamed(
                  context, AppRouter.privateSalaryIncomeScreen);
            },
            child: const Text(
              'Private Salary Income',
              style: TextStyle(fontSize: TextSize.titleText),
            ))
      ]),
    );
  }
}
