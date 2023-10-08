import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
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
          'কর গননা',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taxCalculationProvider.taxCalculationInputList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index != 0)
                        IconButton(
                            onPressed: () {
                              taxCalculationProvider
                                  .removeItemOfRebateCalculationInputList(
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
                              "12. Gross Tax leviable on total income",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .grossTax!),
                          buildRow(
                              "13. Tax Rebate (as per schedule 5)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .taxRebate!),
                          buildRow(
                              "14. Tax payable: After Tax rebate (12-13)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .taxPayableAfterTaxRebate!),
                          buildRow(
                              "15 Minimum tax",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .minimumTax!),
                          buildRow(
                              "16. Tax Payable (Which is Higher of SL NO. 14 and 15)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .taxPayable!),
                          buildRow(
                              "17. Surcharge of Net Wealth (if applicable)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .surchargeOfNetWealth!),
                          buildRow(
                              "18. Surcharge of Environmental (if applicable)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .surchargeOfEnvironmental!),
                          buildRow(
                              "19. Delay Interest, Penalty or any other amount under the Income Tax Act (if any)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .delayInterest!),
                          buildRow(
                              "20. Total TAX Payable (16+17+18)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .totalTaxPayable!),
                          buildRow(
                              "21. Tax deducted or Collected at source (attach proof)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index].taxDeducted!),
                          buildRow(
                              "22. Advance Tax paid (attach proof)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .advanceTax!),
                          buildRow(
                              "23. Adjustment of tax refund [mention assessment year(s) of refund]",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .adjustmentOfTax!),
                          buildRow(
                              "24. Amount paid with return (attach proof)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .amountPaidWithReturn!),
                          buildRow(
                              "25. Total TAX Paid (20+21+22+23)",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .totalTaxPaid!),
                          buildRow(
                              "26. Deficit or excess",
                              taxCalculationProvider
                                  .taxCalculationInputList[index]
                                  .deficitOrExcess!),
                        ],
                      ),
                    ],
                  )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                taxCalculationProvider.addTaxCalculationInputListItem();
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
