import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/solid_button.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/salary_income_provider.dart';

class GovtSalaryIncomeScreen extends StatelessWidget {
  const GovtSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryIncomeProvider incomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'সরকারি বেতনভুক্ত',
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
              itemCount: incomeProvider.govtSalaryIncomeInputList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index != 0)
                    IconButton(
                        onPressed: () {
                          incomeProvider
                              .removeItemOfGovtSalaryIncomeInputList(
                              index);
                        },
                        icon: const Icon(Icons.cancel_rounded,
                            color: Colors.grey),
                        splashRadius: 25,
                        padding: EdgeInsets.zero),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      //Table Header
                      const TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Particulars',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Amount of taka',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      //Table Row
                      buildRow(
                          "1. Basic Pay",
                          incomeProvider
                              .govtSalaryIncomeInputList[index].basicPay!),
                      buildRow(
                          "2. Allowances",
                          incomeProvider
                              .govtSalaryIncomeInputList[index].allowance!),
                      buildRow(
                          "3. Advance salary",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .advanceSalary!),
                      buildRow(
                          "4. Gratuity, Annuity, Pension or similar benefits",
                          incomeProvider
                              .govtSalaryIncomeInputList[index].benefits!),
                      buildRow(
                          "5. Perquisites",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .perquisites!),
                      buildRow(
                          "6. Salary or wages",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .additionalSalaryOrWages!),
                      buildRow(
                          "7. Income employee's from share scheme",
                          incomeProvider
                              .govtSalaryIncomeInputList[index].shareScheme!),
                      buildRow(
                          "8. Accommodation benefits",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .accommodationBenefits!),
                      buildRow(
                          "9. Car Benefits",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .carBenefits!),
                      buildRow(
                          "10. Any other benefits provided by employer",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .anyOtherBenefits!),
                      buildRow(
                          "11. Employee's contribution to recognized provident fund",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .providentFund!),
                      buildRow(
                          "12. Others",
                          incomeProvider
                              .govtSalaryIncomeInputList[index].others!),
                      buildRow(
                          "13. Total salary income (aggregate of 1 to 12)",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .totalSalaryIncome!),
                      buildRow(
                          "14. Exempted salary (As per 6th schedule part 1)",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .exemptedSalary!),
                      buildRow(
                          "15. total income from salary (13-14)",
                          incomeProvider.govtSalaryIncomeInputList[index]
                              .totalIncomeFromSalary!)
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                incomeProvider.addGovtSalaryIncomeInputListItem();
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
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        TableTextFormFieldWidget(
          controller: controller,
          textInputType: TextInputType.number,
          hintText: '0.00',
        ),
      ],
    );
  }
}
