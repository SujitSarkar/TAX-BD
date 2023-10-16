import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/partnership_business_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class PartnershipBusinessIncomeScreen extends StatelessWidget {
  const PartnershipBusinessIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Partnership Business Income',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await partnershipBusinessIncomeProvider.getPartnershipBusinessIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                partnershipBusinessIncomeProvider.partnershipBusinessIncomeInputList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0)
                      IconButton(
                          onPressed: () {
                            partnershipBusinessIncomeProvider
                                .removeItemOfPartnershipBusinessIncomeInputList(index);
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
                                'Summary of Income',
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
                            "1. Particular",
                            partnershipBusinessIncomeProvider
                                .partnershipBusinessIncomeInputList[index]
                                .particular!),
                        buildRow(
                            "2. Tax Paid",
                            partnershipBusinessIncomeProvider
                                .partnershipBusinessIncomeInputList[index]
                                .taxPaid!),
                        buildRow(
                            "3. Profit",
                            partnershipBusinessIncomeProvider
                                .partnershipBusinessIncomeInputList[index]
                                .profit!),
                        buildRow(
                            "4. Salary/Discount/Commission",
                            partnershipBusinessIncomeProvider
                                .partnershipBusinessIncomeInputList[index]
                                .salaryDiscountCommission!),
                        buildRow(
                            "5. Total Profit",
                            partnershipBusinessIncomeProvider
                                .partnershipBusinessIncomeInputList[index]
                                .totalProfit!,readOnly: true),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      partnershipBusinessIncomeProvider.addPartnershipBusinessInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await partnershipBusinessIncomeProvider
                      .submitPartnershipBusinessIncomeButtonOnTap();
                },
                child: partnershipBusinessIncomeProvider.functionLoading
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

  TableRow buildRow(String label, TextEditingController controller,{bool readOnly = false, bool requiredData = false}) {
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
