import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class PrivateSalaryIncomeScreen extends StatelessWidget {
  const PrivateSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryIncomeProvider incomeProvider = Provider.of(context);
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
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index != 0)
                    IconButton(
                        onPressed: () {
                          incomeProvider
                              .removeItemOfPrivateSalaryIncomeInputList(
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
                                  .privateSalaryIncomeInputList[index].basicPay!),
                          buildRow(
                              "2. Allowances",
                              incomeProvider
                                  .privateSalaryIncomeInputList[index].allowance!),
                          buildRow(
                              "3. Advance salary",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .advanceSalary!),
                          buildRow(
                              "4. Gratuity, Annuity, Pension or similar benefits",
                              incomeProvider
                                  .privateSalaryIncomeInputList[index].benefits!),
                          buildRow(
                              "5. Perquisites",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .perquisites!),
                          buildRow(
                              "6. Salary or wages",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .additionalSalaryOrWages!),
                          buildRow(
                              "7. Income employee's from share scheme",
                              incomeProvider
                                  .privateSalaryIncomeInputList[index].shareScheme!),
                          buildRow(
                              "8. Accommodation benefits",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .accommodationBenefits!),
                          buildRow(
                              "9. Car Benefits",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .carBenefits!),
                          buildRow(
                              "10. Any other benefits provided by employer",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .anyOtherBenefits!),
                          buildRow(
                              "11. Employee's contribution to recognized provident fund",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .providentFund!),
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
                              "15. total income from salary (13-14)",
                              incomeProvider.privateSalaryIncomeInputList[index]
                                  .totalIncomeFromSalary!)
                        ],
                      ),
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
