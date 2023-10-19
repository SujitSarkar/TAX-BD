import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/expense_information_provider.dart';

class ExpenseInformationScreen extends StatelessWidget {
  const ExpenseInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseInformationProvider expenseInformationProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Expenses of Lifestyle',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await expenseInformationProvider.getCostInfoData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expenseInformationProvider
                    .expanseInformationInputItemList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                                  onPressed: () {
                                    expenseInformationProvider
                                        .removeItemOfCostInformationInputList(
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
                            ///Table Header
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Particulars of Expenditure',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Amount of Taka',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Comment',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            //Table Row

                            buildRow(
                                "1. Personal and family fooding, clothing and other essentials",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalAndFoodingExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalAndFoodingExpanses!
                                    .comment!),
                            buildRow(
                                "2. Housing Expense",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .houseExpanse!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .houseExpanse!
                                    .comment!),
                            buildRow(
                                "3. Personal Transport Expenses",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalTransportExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalTransportExpanses!
                                    .comment!),
                            buildRow(
                                "4. Utility Expense (Electricity, Gas, Water, Telephone, Mobile, Internet etc. Bills)",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .utilityExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .utilityExpanses!
                                    .comment!),
                            buildRow(
                                "5. Education Expense",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .educationExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .educationExpanses!
                                    .comment!),
                            buildRow(
                                "6. Personal Expenses for local & foreign travel, vacation etc.",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .personalExpanses!
                                    .comment!),
                            buildRow(
                                "7. Festival and Other special expenses",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .festivalExpanses!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .festivalExpanses!
                                    .comment!),
                            buildRow(
                                "8. Tax Deducted / Collected at Source (with TS on Profit of Sanchaypatra) and Tax & Surcharge Paid based on Tax Return of Last Year)  ",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .taxDeduction!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .taxDeduction!
                                    .comment!),
                            buildRow(
                                "9. Interest Paid on Personal Loan Received from Institution & Other Source",
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .interestPaid!
                                    .amount!,
                                expenseInformationProvider
                                    .expanseInformationInputItemList[index]
                                    .interestPaid!
                                    .comment!),

                            ///Total
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TableTextFormFieldWidget(
                                      controller: expenseInformationProvider.expanseInformationInputItemList[index].total!,
                                      hintText: '0.00',
                                      required: false,
                                    readOnly: true,
                                )),const SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      expenseInformationProvider
                          .addCostInformationInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await expenseInformationProvider.submitDataButtonOnTap();
                },
                child: expenseInformationProvider.functionLoading
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

  TableRow buildRow(String label, TextEditingController amountController,
      TextEditingController commentController,
      {bool readOnly = false, bool requiredData = false}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        TableTextFormFieldWidget(
          controller: amountController,
          textInputType: TextInputType.number,
          hintText: '0.00',
          required: requiredData,
          readOnly: readOnly,
        ),
        TableTextFormFieldWidget(
          controller: commentController,
          hintText: '',
          required: false,
        ),
      ],
    );
  }
}
