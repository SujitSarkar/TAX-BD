import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class PrivateSalaryIncomeScreen extends StatelessWidget {
  const PrivateSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Private Salary Income',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await salaryIncomeProvider.getPrivateSalaryIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            const Text(
                'This part is applicable for employees other then Govt. pay scale',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    salaryIncomeProvider.privateSalaryIncomeInputList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                salaryIncomeProvider
                                    .removeItemOfPrivateSalaryIncomeInputList(
                                        index);
                              },
                              icon: const Icon(Icons.cancel_rounded,
                                  color: Colors.grey),
                              splashRadius: 25,
                              padding: EdgeInsets.zero),
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(color: Colors.grey),
                          children: [
                            //Table Header
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Particulars',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Amount of taka',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            //Table Row
                            buildRow(
                                "1. Basic Pay",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .basicPay!),
                            buildRow(
                                "2. Allowances",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .allowance!),
                            buildRow(
                                "3. Advance salary",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .advanceSalary!),
                            buildRow(
                                "4. Gratuity, Annuity, Pension or similar benefits",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .gratuityAnnuity!),
                            buildRow(
                                "5. Perquisites",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .perquisites!),
                            buildRow(
                                "6. Receipt in lieu of or in addition to Salary or Wages",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .additionalSalaryOrWages!),
                            buildRow(
                                "7. Income employee's from share scheme",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .shareScheme!),
                            buildRow(
                                "8. Accommodation facility",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .accommodationFacility!),
                            buildRow(
                                "9. Transport facility",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .transportFacility!),
                            buildRow(
                                "10. Any other facility provided by employer",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .anyOtherFacility!),
                            buildRow(
                                "11. Employer's contribution to recognized provident fund",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .providentFund!),
                            buildRow(
                                "12. Others, if any",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .others!),
                            buildRow(
                                "13. Total Salary Received (aggregate of 1 to 12)",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .totalSalaryReceived!,
                                readOnly: true,isBold: true),
                            buildRow(
                                "14. Exempted Amount (as per Part 1 of 6th Schedule)",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .exemptedAmount!,readOnly: true),
                            buildRow(
                                "15. Total income from salary (13-14)",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .totalIncomeFromSalary!,
                                readOnly: true,isBold: true)
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      salaryIncomeProvider
                          .addPrivateSalaryIncomeInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await salaryIncomeProvider
                      .submitPrivateSalaryIncomeButtonOnTap();
                },
                child: salaryIncomeProvider.functionLoading
                    ? const LoadingWidget()
                    : const Text(
                        'Submit Data',
                        style: TextStyle(fontSize: TextSize.titleText),
                      ))
          ]),
        ),
      ),
    );
  }

  TableRow buildRow(String label, TextEditingController controller,
      {bool readOnly = false, bool requiredData = false,bool isBold = false}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label,style: TextStyle(fontWeight: isBold?FontWeight.bold:null))),
        TableTextFormFieldWidget(
          controller: controller,
          textInputType: TextInputType.number,
          hintText: '0.00',
          readOnly: readOnly,
          required: requiredData,
        ),
      ],
    );
  }
}
