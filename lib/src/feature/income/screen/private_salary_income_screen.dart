import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class PrivateSalaryIncomeScreen extends StatelessWidget {
  const PrivateSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final IncomeProvider incomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'বেসরকারি বেতনভুক্ত',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: incomeProvider.privateSalaryIncomeInputList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 50),
              itemBuilder: (context, index) => Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      buildRow(
                          "1. Basic Pay",
                          incomeProvider
                              .privateSalaryIncomeInputList[index].basicPay!),
                      buildRow(
                          "2. Allowances",
                          incomeProvider
                              .privateSalaryIncomeInputList[index].allowence!),
                      buildRow(
                          "3. Advance salary",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .advanceSalary!),
                      buildRow(
                          "4. Gratuity, Annuity, Penssion or simmiler benefits",
                          incomeProvider
                              .privateSalaryIncomeInputList[index].benefits!),
                      buildRow(
                          "5. Perquisites",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .perquisites!),
                      buildRow(
                          "6. Salary or wagws",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .additionalSalaryOrWages!),
                      buildRow(
                          "7. Income employee's from share scheme",
                          incomeProvider
                              .privateSalaryIncomeInputList[index].shareSceme!),
                      buildRow(
                          "8. Accomodation benefits",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .accomodationBenefits!),
                      buildRow(
                          "9. Car Benefits",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .carBenefits!),
                      buildRow(
                          "10. Any other benefits provided by employer",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .anyOtherBenefits!),
                      buildRow(
                          "11. Employee's contribution to recogniged provident fund",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .providendFund!),
                      buildRow(
                          "12. Others",
                          incomeProvider
                              .privateSalaryIncomeInputList[index].others!),
                      buildRow(
                          "13. Total salary income (aggregate of 1 to 12)",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .totalSalaryIncome!),
                      buildRow(
                          "14. Exempted salary (As per 6th schedule part 1)",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .exemptedSalary!),
                      buildRow(
                          "15. total incmoe from salary (13-14)",
                          incomeProvider.privateSalaryIncomeInputList[index]
                              .totalIncomeFromSalary!)
                    ],
                  )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                incomeProvider.addPrivateSalaryIncomeInputListItem();
              },
              child: const Text(
                'আরেকটি বিবরনি যোগ',
                style: TextStyle(fontSize: TextSize.titleText),
              ))
        ]),
      ),
    );
  }

  TableRow buildRow(String label, TextEditingController controller) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TableTextFormFieldWidget(
          controller: controller,
          textInputType: TextInputType.number,
          hintText: '0.00',
        ),
      ],
    );
  }
}
