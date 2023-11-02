import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/investment/provider/investment_provider.dart';
import 'package:tax_bd/src/shared/widget/loading_widget.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InvestmentProvider investmentProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Investment',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await investmentProvider.getRebateCalculationData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: investmentProvider
                    .investmentInputList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                investmentProvider
                                    .removeItemOfInvestmentInputList(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Amount of taka',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            //Table Row
                            buildRow(
                                "1. Life Insurance Premium or Contractual Deferred Annuity Paid in Bangladesh",
                                investmentProvider
                                    .investmentInputList[index]
                                    .lifeInsurance!),
                            buildRow(
                                "2. Contribution to deposit pension scheme",
                                investmentProvider
                                    .investmentInputList[index]
                                    .contributionToDepositPerson!),
                            buildRow(
                                "3. Investment in Government Securities, Unit Certificate, Mutual Fund, ETF or Joint Investment Scheme Unit Certificate",
                                investmentProvider
                                    .investmentInputList[index]
                                    .investmentInGovt!),
                            buildRow(
                                "4. Investment in Securities listed with Approved Stock Exchange",
                                investmentProvider
                                    .investmentInputList[index]
                                    .investmentInSecurity!),
                            buildRow(
                                "5.	Contribution to Provident Fund to which Provident Fund Act, 1925 applies",
                                investmentProvider
                                    .investmentInputList[index]
                                    .contributionToProvident!),
                            buildRow(
                                "6.	Self & Employer’s Contribution to Recognized Provident Fund",
                                investmentProvider
                                    .investmentInputList[index]
                                    .selfContribution!),
                            buildRow(
                                "7.	Contribution to Super Annuation Fund",
                                investmentProvider
                                    .investmentInputList[index]
                                    .contributionToApproved!),
                            buildRow(
                                "8.	Contribution to Benevolent Fund / Group Insurance Premium",
                                investmentProvider
                                    .investmentInputList[index]
                                    .contributionToBenevolent!),
                            buildRow(
                                "9. Contribution to Zakat Fund",
                                investmentProvider
                                    .investmentInputList[index]
                                    .contributionToZakat!,requiredData: false),
                            buildRow(
                                "10. Others, if any (provide details)",
                                investmentProvider
                                    .investmentInputList[index]
                                    .others!,
                                requiredData: false),
                            buildRow(
                                "11. Total investment (aggregate of 1 to 10)",
                                investmentProvider
                                    .investmentInputList[index]
                                    .totalInvestment!,
                                readOnly: true,
                                requiredData: false),
                            buildRow(
                                "12. Amount of Tax Rebate",
                                investmentProvider
                                    .investmentInputList[index]
                                    .amountOfTax!,readOnly: true),
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      investmentProvider
                          .addInvestmentInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await investmentProvider.submitDataButtonOnTap();
                },
                child: investmentProvider.functionLoading
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
      {bool readOnly = false, bool requiredData = true}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
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
