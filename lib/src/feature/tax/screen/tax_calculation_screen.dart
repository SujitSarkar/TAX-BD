import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class TaxCalculationScreen extends StatelessWidget {
  const TaxCalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaxCalculationProvider taxCalculationProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Tax Calculation',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await taxCalculationProvider.getTaxCalculationData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    taxCalculationProvider.taxCalculationInputList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                                  onPressed: () {
                                    taxCalculationProvider
                                        .removeItemOfTaxCalculationInputList(
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
                                    'Particulars of Income',
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
                                "1. Income from Employment (annex Schedule 1)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromEmployment!,readOnly: true),
                            buildRow(
                                "2. Income from Rent (annex Schedule 2)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromRent!,readOnly: true),
                            buildRow(
                                "3. Income from Agriculture (annex Schedule 3)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromAgriculture!,readOnly: true),
                            buildRow(
                                "4. Income from Business (annex Schedule 4)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromBusiness!,readOnly: true),
                            buildRow(
                                "5. Income from Capital Gain",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromCapitalGain!,readOnly: true),
                            buildRow(
                                "6. Income from Financial Assets(Bank Interest, Dividend, Securities Profit etc)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromFinancialAsset!,readOnly: true),
                            buildRow(
                                "7. Income from Other Sources(Royalty, License Fees, Honorarium, Govt. Incentive etc.)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromOtherSource!,readOnly: true),
                            buildRow(
                                "8. Share of Income from Firm or AoP",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromFirm!,readOnly: true),
                            buildRow(
                                "9. Income of Minor or Spouse (if not Taxpayer)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromMinorOrSpouse!,readOnly: true),
                            buildRow(
                                "10. Taxable Income from Abroad",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].incomeFromAbroad!,readOnly: true),
                            buildRow(
                                "11. Total Income (Aggregate of Serial 1 to 10)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].totalIncome!,readOnly: true,isBold: true),

                            buildRow(
                                "12. Gross Tax on Taxable Income",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].grossTax!),
                            buildRow(
                                "13. Tax Rebate (annex Schedule 5)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index].taxRebate!,readOnly: true),
                            buildRow(
                                "14. Net Tax after Rebate (12–13)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .netTaxAfterRebate!,
                                readOnly: true),
                            buildRow(
                                "15 Minimum Tax",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .minimumTax!),
                            buildRow(
                                "16. Tax Payable (Higher of 14 and 15)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .taxPayable!,readOnly: true),
                            buildRow(
                                "17(a). Net Wealth Surcharge (if applicable)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .netWealthSurcharge!),
                            buildRow(
                                "(b). Environmental Surcharge (if applicable)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .environmentalSurcharge!),
                            buildRow(
                                "18. Delay Interest, Penalty or any other amountUnder Income Tax Act (if any)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .delayInterest!),
                            buildRow(
                                "19. Total Amount Payable (16+17+18)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .totalAmountPayable!,
                                readOnly: true,isBold: true),
                            buildRow(
                                "20. Tax Deducted or Collected at Source (attach proof)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .taxDeductedSource!),
                            buildRow(
                                "21. Advance Tax paid (attach proof)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .advanceTaxPaid!),
                            buildRow(
                                "22. Adjustment of Tax Refund {mention assessment year(s) of refund}",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .adjustmentOfTax!),
                            buildRow(
                                "23. Tax Paid with this Return",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .taxPaidWithReturn!),
                            buildRow(
                                "24. Total Tax Paid and Adjusted (20+21+22+23)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .totalTaxPaid!,
                                readOnly: true,isBold: true),
                            buildRow(
                                "25. Excess Payment (24–19)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .excessPayment!,
                                readOnly: true),
                            buildRow(
                                "26. Tax Exempted/Tax Free Income (attach proof)",
                                taxCalculationProvider
                                    .taxCalculationInputList[index]
                                    .taxExempted!),
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      taxCalculationProvider.addTaxCalculationInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await taxCalculationProvider.submitDataButtonOnTap();
                },
                child: taxCalculationProvider.functionLoading
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
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label,style: TextStyle(fontWeight: isBold?FontWeight.bold:null),)),
        TableTextFormFieldWidget(
          controller: controller,
          textInputType: TextInputType.number,
          hintText: '0.00',
          required: requiredData,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
