import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/business_income_provider.dart';

class BusinessIncomeScreen extends StatelessWidget {
  const BusinessIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BusinessIncomeProvider businessIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'ব্যবসার আয়',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          TextFormFieldWidget(
              controller: businessIncomeProvider.nameOfBusinessController,
              labelText: 'Name of business/profession',
              maxLine: 2,
              hintText: 'Enter name of business/profession',
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 16),
          TextFormFieldWidget(
              controller: businessIncomeProvider.nameOfBusinessController,
              labelText: 'Nature of business',
              maxLine: 2,
              hintText: 'Enter Nature of business',
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 16),
          TextFormFieldWidget(
              controller: businessIncomeProvider.nameOfBusinessController,
              labelText: 'Organization type',
              maxLine: 2,
              hintText: 'Enter organization type',
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 16),
          TextFormFieldWidget(
              controller: businessIncomeProvider.addressController,
              labelText: 'Address',
              hintText: 'Enter Address',
              textInputType: TextInputType.number),
          const SizedBox(height: 20),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: businessIncomeProvider.businessIncomeInputList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index != 0)
                        IconButton(
                            onPressed: () {
                              businessIncomeProvider
                                  .removeItemOfBusinessIncomeInputList(index);
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
                              "1. Sale/Turnover/Receipts",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .saleTurnoverReceipts!),
                          buildRow(
                              "2. Gross Profit",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].grossProfit!),
                          buildRow(
                              "3. General Expanses, Selling Expanses, Land Revenue, Rates, Interest of Loan, Insurance Premium & Other Expenses",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .generalExpanses!),
                          buildRow(
                              "4. Bad debt expense",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .badDebtExpanses!),
                          buildRow(
                              "5. Net Profit (2-3-4)",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].netProfit!),

                          //Table Header
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Summary of Balance Sheet',
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
                              "6. Cash & Bank Sheet",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .cashAndBankBalance!),
                          buildRow(
                              "7. Inventory",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].inventory!),
                          buildRow(
                              "8. Fixed Assets",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].fixedAssets!),
                          buildRow(
                              "9. Other Assets",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].otherAssets!),
                          buildRow(
                              "10. Total Assets",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].totalAssets!),
                          buildRow(
                              "11. Opening Capital",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .openingCapital!),
                          buildRow(
                              "12. Net Profit",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .balanceSheetNetProfit!),
                          buildRow(
                              "13. Drawing during the income year",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .drawingDuringIncomeYear!),
                          buildRow(
                              "14. Closing Capital (11+12+13)",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .closingCapital!),
                          buildRow(
                              "15. Liabilities",
                              businessIncomeProvider
                                  .businessIncomeInputList[index].liabilities!),
                          buildRow(
                              "16. Total Capital & Liabilities (14+15)",
                              businessIncomeProvider
                                  .businessIncomeInputList[index]
                                  .totalCapitalAndLiabilities!),
                        ],
                      ),
                    ],
                  )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                businessIncomeProvider.addBusinessIncomeInputListItem();
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
