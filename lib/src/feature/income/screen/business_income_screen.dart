import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
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
          'Income from Business',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await businessIncomeProvider.getBusinessIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: businessIncomeProvider.businessIncomeKey,
            child: Column(children: [
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
                          TextFormFieldWidget(
                              controller: businessIncomeProvider.businessIncomeInputList[index]
                                  .nameOfBusiness!,
                              labelText: 'Name of Business',
                              maxLine: 2,
                              hintText: 'Enter Name of Business',
                              required: true,
                              textCapitalization: TextCapitalization.words),
                          const SizedBox(height: 16),
                          TextFormFieldWidget(
                              controller: businessIncomeProvider.businessIncomeInputList[index]
                                  .natureOfBusiness!,
                              labelText: 'Nature of Business',
                              maxLine: 2,
                              hintText: 'Enter Nature of Business',
                              required: true,
                              textCapitalization: TextCapitalization.words),
                          const SizedBox(height: 16),
                          TextFormFieldWidget(
                              controller: businessIncomeProvider.businessIncomeInputList[index]
                                  .addressOfBusiness!,
                              labelText: 'Address of Business',
                              hintText: 'Enter Address of Business',
                              required: true,
                              textCapitalization: TextCapitalization.sentences),
                          const SizedBox(height: 16),
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
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .saleTurnoverReceipt!),
                              buildRow(
                                  "2. Gross Profit",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].grossProfit!),
                              buildRow(
                                  "3. General, Administrative, Selling and Other Expenses ",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .generalExpanses!),
                              buildRow(
                                  "4. Bad debt expense",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .badDebtExpanses!),
                              buildRow(
                                  "5. Net Profit (2-3)",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].netProfit!,readOnly: true),
                              buildRow(
                                  "6. Exempted if any",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].exemptedAmount!),

                              ///Table Header
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
                                  "7. Cash & Bank Balance",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .cashAndBankBalance!),
                              buildRow(
                                  "8. Inventory",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].inventory!),
                              buildRow(
                                  "9. Fixed Assets",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].fixedAssets!),
                              buildRow(
                                  "10. Other Assets",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].otherAssets!),
                              buildRow(
                                  "11. Total Assets (7+8+9+10)",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].totalAssets!,readOnly: true),
                              buildRow(
                                  "12. Opening Capital",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .openingCapital!),
                              buildRow(
                                  "13. Net Profit",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .balanceSheetNetProfit!,readOnly: true),
                              buildRow(
                                  "14. Drawing during the income year",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .drawingDuringIncomeYear!),
                              buildRow(
                                  "15. Closing Capital (12+13-14)",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .closingCapital!,readOnly: true),
                              buildRow(
                                  "16. Liabilities",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index].liabilities!),
                              buildRow(
                                  "17. Total Capital & Liabilities (15+16)",
                                  businessIncomeProvider
                                      .businessIncomeInputList[index]
                                      .totalCapitalAndLiabilities!,readOnly: true),
                            ],
                          ),
                        ],
                      )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        businessIncomeProvider
                            .addBusinessInputListItem();
                      },
                      child: const Text('Add More'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await businessIncomeProvider
                        .submitBusinessIncomeButtonOnTap();
                  },
                  child: businessIncomeProvider.functionLoading
                      ? const LoadingWidget()
                      : const Text(
                    'Submit Data',
                    style: TextStyle(fontSize: TextSize.titleText),
                  ))
            ]),
          ),
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
