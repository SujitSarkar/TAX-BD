import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
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
          'কৃষি আয়',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          TextFormFieldWidget(
              controller: agriculturalIncomeProvider.nameOfAddressController,
              labelText: 'Name of address',
              maxLine: 2,
              hintText: 'Enter name of address',
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 16),
          TextFormFieldWidget(
              controller: agriculturalIncomeProvider.tinController,
              labelText: 'TIN',
              hintText: 'Enter TIN',
              textInputType: TextInputType.number),
          const SizedBox(height: 20),
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
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                              agriculturalIncomeProvider
                                  .agricultureIncomeInputList[index]
                                  .saleTurnoverReceipts!),
                          buildRow(
                              "2. Gross Profit",
                              agriculturalIncomeProvider
                                  .agricultureIncomeInputList[index].grossProfit!),
                          buildRow(
                              "3. General Expanses, Selling Expanses, Land Revenue, Rates, Interest of Loan, Insurance Premium and Other Expenses",
                              agriculturalIncomeProvider
                                  .agricultureIncomeInputList[index]
                                  .generalExpanses!),
                          buildRow(
                              "4. Net Profit (2-3)",
                              agriculturalIncomeProvider
                                  .agricultureIncomeInputList[index].netProfit!),
                        ],
                      ),
                ],
              )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                agriculturalIncomeProvider.addAgricultureIncomeInputListItem();
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
