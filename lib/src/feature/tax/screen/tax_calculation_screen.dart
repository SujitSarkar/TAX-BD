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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(children: [
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
                        'Particulars of Income',
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
                buildRow("1. Income from Employment (annex Schedule 1)",
                    taxCalculationProvider.incomeFromEmployment,
                    readOnly: true),
                buildRow("2. Income from Rent (annex Schedule 2)",
                    taxCalculationProvider.incomeFromRent,
                    readOnly: true),
                buildRow("3. Income from Agriculture (annex Schedule 3)",
                    taxCalculationProvider.incomeFromAgriculture,
                    readOnly: true),
                buildRow("4. Income from Business (annex Schedule 4)",
                    taxCalculationProvider.incomeFromBusiness,
                    readOnly: true),
                buildRow("5. Income from Capital Gain",
                    taxCalculationProvider.incomeFromCapitalGain,
                    readOnly: true),
                buildRow(
                    "6. Income from Financial Assets(Bank Interest, Dividend, Securities Profit etc)",
                    taxCalculationProvider.incomeFromFinancialAsset,
                    readOnly: true),
                buildRow(
                    "7. Income from Other Sources(Royalty, License Fees, Honorarium, Govt. Incentive etc.)",
                    taxCalculationProvider.incomeFromOtherSource,
                    readOnly: true),
                buildRow("8. Share of Income from Firm or AoP",
                    taxCalculationProvider.incomeFromFirm,
                    readOnly: true),
                buildRow("9. Income of Minor or Spouse (if not Taxpayer)",
                    taxCalculationProvider.incomeFromMinorOrSpouse,
                    readOnly: true),
                buildRow("10. Taxable Income from Abroad",
                    taxCalculationProvider.incomeFromAbroad,
                    readOnly: true),
                buildRow("11. Total Income (Aggregate of Serial 1 to 10)",
                    taxCalculationProvider.totalIncome,
                    readOnly: true, isBold: true),

                buildRow("12. Gross Tax on Taxable Income",
                    taxCalculationProvider.grossTax,readOnly: true),
                buildRow("13. Tax Rebate (annex Schedule 5)",
                    taxCalculationProvider.taxRebate,
                    readOnly: true),
                buildRow("14. Net Tax after Rebate (12–13)",
                    taxCalculationProvider.netTaxAfterRebate,
                    readOnly: true),
                buildRow("15 Minimum Tax", taxCalculationProvider.minimumTax,readOnly: true),
                buildRow("16. Tax Payable (Higher of 14 and 15)",
                    taxCalculationProvider.taxPayable,
                    readOnly: true),
                buildRow("17(a). Net Wealth Surcharge (if applicable)",
                    taxCalculationProvider.netWealthSurcharge,
                    readOnly: true),
                buildRow("(b). Environmental Surcharge (if applicable)",
                    taxCalculationProvider.environmentalSurcharge),
                buildRow(
                    "18. Delay Interest, Penalty or any other amountUnder Income Tax Act (if any)",
                    taxCalculationProvider.delayInterest),
                buildRow("19. Total Amount Payable (16+17+18)",
                    taxCalculationProvider.totalAmountPayable,
                    readOnly: true, isBold: true),
                buildRow(
                    "20. Tax Deducted or Collected at Source (attach proof)",
                    taxCalculationProvider.taxDeductedSource),
                buildRow("21. Advance Tax paid (attach proof)",
                    taxCalculationProvider.advanceTaxPaid),
                buildRow(
                    "22. Adjustment of Tax Refund {mention assessment year(s) of refund}",
                    taxCalculationProvider.adjustmentOfTax),
                buildRow("23. Tax Paid with this Return",
                    taxCalculationProvider.taxPaidWithReturn),
                buildRow("24. Total Tax Paid and Adjusted (20+21+22+23)",
                    taxCalculationProvider.totalTaxPaid,
                    readOnly: true, isBold: true),
                buildRow("25. Excess Payment (24–19)",
                    taxCalculationProvider.excessPayment,
                    readOnly: true),
                buildRow("26. Tax Exempted/Tax Free Income (attach proof)",
                    taxCalculationProvider.taxExempted),
              ],
            ),
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
      {bool readOnly = false, bool requiredData = false, bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : null),
            )),
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
