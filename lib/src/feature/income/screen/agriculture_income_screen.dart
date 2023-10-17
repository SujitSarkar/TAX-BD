import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class AgricultureIncomeScreen extends StatelessWidget {
  const AgricultureIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AgriculturalIncomeProvider agriculturalIncomeProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income from Agriculture',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await agriculturalIncomeProvider.getAgricultureIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            const Text('Schedule 3',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('(This part is applicable for agriculture income)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: TextSize.bodyText)),
            const SizedBox(height: 16),

            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    agriculturalIncomeProvider.agricultureIncomeInputList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                agriculturalIncomeProvider
                                    .removeItemOfAgricultureIncomeInputList(
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
                                "1. Sale/Turnover/Receipt",
                                agriculturalIncomeProvider
                                    .agricultureIncomeInputList[index]
                                    .saleTurnoverReceipt!),
                            buildRow(
                                "2. Gross Profit",
                                agriculturalIncomeProvider
                                    .agricultureIncomeInputList[index]
                                    .grossProfit!),
                            buildRow(
                                "3. General Expanses, Selling Expanses, Land Revenue, Rates, Interest of Loan, Insurance Premium and Other Expenses",
                                agriculturalIncomeProvider
                                    .agricultureIncomeInputList[index]
                                    .generalExpanses!),
                            buildRow(
                                "4. Net Profit (2-3)",
                                agriculturalIncomeProvider
                                    .agricultureIncomeInputList[index]
                                    .netProfit!,readOnly: true),
                            buildRow(
                                "4. Exempted if any",
                                agriculturalIncomeProvider
                                    .agricultureIncomeInputList[index]
                                    .exemptedAmount!),

                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      agriculturalIncomeProvider
                          .addAgricultureInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await agriculturalIncomeProvider
                      .submitAgricultureIncomeButtonOnTap();
                },
                child: agriculturalIncomeProvider.functionLoading
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
