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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                                  child: FittedBox(
                                    child: Text(
                                      'Particulars',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      'Amount',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      'Exempted',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Taxable',
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
                                    .basicPay!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .basicPay!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .basicPay!
                                    .taxable!),
                            buildRow(
                                "2. Arrear Pay (if not included in taxable income earlier)",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .arrearPay!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .arrearPay!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .arrearPay!
                                    .taxable!),
                            buildRow(
                                "3. Special allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .specialAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .specialAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .specialAllowance!
                                    .taxable!),
                            buildRow(
                                "4. House Rent allowance ",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .houseRentAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .houseRentAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .houseRentAllowance!
                                    .taxable!),
                            buildRow(
                                "5. Medical allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .medicalAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .medicalAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .medicalAllowance!
                                    .taxable!),
                            buildRow(
                                "6. Conveyance allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .conveyanceAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .conveyanceAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .conveyanceAllowance!
                                    .taxable!),
                            buildRow(
                                "7. Festival allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .festivalAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .festivalAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .festivalAllowance!
                                    .taxable!),
                            buildRow(
                                "8. Support Staff allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .supportStaffAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .supportStaffAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .supportStaffAllowance!
                                    .taxable!),
                            buildRow(
                                "9. Leave allowance",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .leaveAllowance!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .leaveAllowance!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .leaveAllowance!
                                    .taxable!),
                            buildRow(
                                "10. Honorarium / Reward",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .honorariumReward!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .honorariumReward!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .honorariumReward!
                                    .taxable!),
                            buildRow(
                                "11. Overtime allowances",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .overtimeAllowances!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .overtimeAllowances!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .overtimeAllowances!
                                    .taxable!),
                            buildRow(
                                "12. Bangla Noboborsho allowances",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .banglaNoboborshoAllowances!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .banglaNoboborshoAllowances!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .banglaNoboborshoAllowances!
                                    .taxable!),
                            buildRow(
                                "13. Interest accrued on Provident Fund",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .interestAccruedOnProvidentFund!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .interestAccruedOnProvidentFund!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .interestAccruedOnProvidentFund!
                                    .taxable!),
                            buildRow(
                                "14. Lump Grant",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .lumpGrant!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .lumpGrant!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .lumpGrant!
                                    .taxable!),
                            buildRow(
                                "15. Gratuity",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .gratuity!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .gratuity!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .gratuity!
                                    .taxable!),
                            buildRow(
                                "16. Others",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .others!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .others!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .others!
                                    .taxable!),
                            buildRow(
                                "17. Total",
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .total!
                                    .amount!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .total!
                                    .exempted!,
                                salaryIncomeProvider
                                    .govtSalaryIncomeInputList[index]
                                    .total!
                                    .taxable!,
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

  TableRow buildRow(String label, TextEditingController amount,
      TextEditingController exempted, TextEditingController taxable,
      {bool readOnly = false, bool requiredData = false}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        TableTextFormFieldWidget(
          controller: amount,
          textInputType: TextInputType.number,
          hintText: '0.00',
          readOnly: readOnly,
          required: requiredData,
        ),
        TableTextFormFieldWidget(
          controller: exempted,
          textInputType: TextInputType.number,
          hintText: '0.00',
          readOnly: readOnly,
          required: requiredData,
        ),
        TableTextFormFieldWidget(
          controller: taxable,
          textInputType: TextInputType.number,
          hintText: '0.00',
          readOnly: true,
          required: requiredData,
        ),
      ],
    );
  }
}
