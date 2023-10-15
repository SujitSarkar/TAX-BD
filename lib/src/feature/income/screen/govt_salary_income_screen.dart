import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/solid_button.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/salary_income_provider.dart';

class GovtSalaryIncomeScreen extends StatelessWidget {
  const GovtSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Govt. Salary Income',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await salaryIncomeProvider.getGovtSalaryIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    salaryIncomeProvider.govtSalaryIncomeInputList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                salaryIncomeProvider
                                    .removeItemOfGovtSalaryIncomeInputList(
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
                                    .govtSalaryIncomeInputList[index]
                                    .basicPay!),
                            buildRow(
                                "2. Arrear Pay (if not included in taxable income earlier)",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .arrearPay!),
                            buildRow(
                                "3. Special allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .specialAllowance!),
                            buildRow(
                                "4. House Rent allowance ",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .houseRentAllowance!),
                            buildRow(
                                "5. Medical allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .medicalAllowance!),
                            buildRow(
                                "6. Conveyance allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .conveyanceAllowance!),
                            buildRow(
                                "7. Festival allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .festivalAllowance!),
                            buildRow(
                                "8. Support Staff allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .supportStaffAllowance!),
                            buildRow(
                                "9. Leave allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .leaveAllowance!),
                            buildRow(
                                "10. Honorarium / Reward",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .honorariumReward!),
                            buildRow(
                                "11. Overtime allowances",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .overtimeAllowances!),
                            buildRow(
                                "12. Bangla Noboborsho allowances",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .banglaNoboborshoAllowances!),
                            buildRow(
                                "13. Interest accrued on Provident Fund",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .interestAccruedOnProvidentFund!),
                            buildRow(
                                "14. Lump Grant",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .lumpGrant!),
                            buildRow(
                                "15. Gratuity",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .gratuity!),
                            buildRow(
                                "16. Others",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index].others!),
                            buildRow(
                                "17. Total",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index].total!,
                                readOnly: true)
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      salaryIncomeProvider.addGovtSalaryIncomeInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await salaryIncomeProvider
                      .submitGovtSalaryIncomeButtonOnTap();
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
      {bool readOnly = false, bool requiredData = false}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
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
