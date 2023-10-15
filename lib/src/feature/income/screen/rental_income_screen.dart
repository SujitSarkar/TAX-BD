import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class RentalIncomeScreen extends StatelessWidget {
  const RentalIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RentalIncomeProvider rentalIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income from Rent',
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
              itemCount:
              rentalIncomeProvider.rentalIncomeInputList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index != 0)
                    IconButton(
                        onPressed: () {
                          rentalIncomeProvider
                              .removeItemOfRentalIncomeInputList(
                              index);
                        },
                        icon: const Icon(Icons.cancel_rounded,
                            color: Colors.grey),
                        splashRadius: 25,
                        padding: EdgeInsets.zero),
                  TextFormFieldWidget(
                      controller: rentalIncomeProvider.rentalIncomeInputList[index].locationAndDescription!,
                      labelText: 'Location, description and ownership proportion of property',
                      maxLine: 4,
                      hintText: 'Enter location, description and ownership proportion of property',
                      textCapitalization: TextCapitalization.words),
                  const SizedBox(height: 12),

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
                              'Total rent income computation',
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
                          "1. Rent receipt or Annual Value (whichever is higher)",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index]
                              .rentReceipt!),
                      buildRow(
                          "2. Advance rent receipts",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].advanceRentReceipt!),
                      buildRow(
                          "3. Value of any benefits (in addition to 1 & 2)",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index]
                              .valueOfAnyBenefits!),
                      buildRow(
                          "4. Adjusted advance rent",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].adjustedAdvanceRent!),
                      buildRow(
                          "5. Vacancy Allowance",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].vacancyAllowance!),
                      buildRow(
                          "6. Total Rent Income (1+2+3)-4-5",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].totalRentIncome!),
                      const TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '7. Allowance deduction',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      buildRow(
                          "a) Repair, Collection, etc.",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].repairAD!),
                      buildRow(
                          "b) Municipal or Local Tax",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].municipalAD!),
                      buildRow(
                          "c) Land Revenue",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].landAD!),
                      buildRow(
                          "d) Interest on Loan Mortgage/Capital Charge",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].interestAD!),
                      buildRow(
                          "e) Insurance Premium",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].insuranceAD!),
                      buildRow(
                          "f) Other, if any",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].otherAD!),
                      buildRow(
                          "8. Total Admissible deductions",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].totalAdmissibleDeduction!),
                      buildRow(
                          "9. Income from house property (06-08)",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].incomeFromHouseProperty!),
                      buildRow(
                          "10. Incase of partial ownership, the share of income",
                          rentalIncomeProvider
                              .rentalIncomeInputList[index].inCaseOfPartial!),
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 12),
          SolidButton(
              onTap: () {
                rentalIncomeProvider.addRentalIncomeInputListItem();
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
