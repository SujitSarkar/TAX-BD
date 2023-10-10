import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/loading_widget.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/rebate_calculation_provider.dart';

class RebateCalculationScreen extends StatelessWidget {
  const RebateCalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RebateCalculationProvider rebateCalculationProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'রেয়াত হিসাব',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=> await rebateCalculationProvider.getRebateCalculationData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
          child: Form(
            key: rebateCalculationProvider.rebateCalculationFormKey,
            child: Column(children: [
              TextFormFieldWidget(
                  controller: rebateCalculationProvider.nameOfAssesseeController,
                  labelText: 'Name of assessee',
                  maxLine: 2,
                  hintText: 'Enter name of assessee',
                  required: true,
                  textCapitalization: TextCapitalization.words),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                  controller: rebateCalculationProvider.tinController,
                  labelText: 'TIN',
                  hintText: 'Enter TIN',
                  required: true,
                  textInputType: TextInputType.number),
              const SizedBox(height: 20),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      rebateCalculationProvider.rebateCalculationInputList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index != 0)
                            IconButton(
                                onPressed: () {
                                  rebateCalculationProvider
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
                                  "1. Life insurance premium or Contractual \"Deferred Annuity\" paid inBangladesh",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .lifeInsurance!),
                              buildRow(
                                  "2. Contribution to deposit pension/Monthly Saving scheme (not exceeding allowable limit)",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .contributionToDepositPerson!),
                              buildRow(
                                  "3. Investment in Govt securities, Unit certificate, Mutual fund, ETF or Joint investment scheme Unit",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .investmentInGovt!),
                              buildRow(
                                  "4. Investment in securities listed with approved Stock Exchange",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .investmentInSecurity!),
                              buildRow(
                                  "5. Contribution to provident fund to which Provident Fund Act, 1925 applies",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .contributionToProvident!),
                              buildRow(
                                  "6. Self contribution and employer's contribution to Recognized Provident Fund",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .selfContribution!),
                              buildRow(
                                  "7. Contribution to approved Pension Fund",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .contributionToApproved!),
                              buildRow(
                                  "8. Contribution to Benevolent Fund and Group Insurance Premium",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .contributionToBenevolent!),
                              buildRow(
                                  "9. Contribution to Zakat Fund",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .contributionToZakat!),
                              buildRow(
                                  "10. Others, if any",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index].others!,requiredData: false),
                              buildRow(
                                  "11. Total investment (aggregate of 1 to 10)",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .totalInvestment!,readOnly: true,requiredData: false),
                              buildRow(
                                  "12. Amount of Tax Rebate",
                                  rebateCalculationProvider
                                      .rebateCalculationInputList[index]
                                      .amountOfTax!),
                            ],
                          ),
                        ],
                      )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        rebateCalculationProvider
                            .addRebateCalculationInputListItem();
                      },
                      child: const Text('আরেকটি বিবরনি যোগ'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await rebateCalculationProvider.submitDataButtonOnTap();
                  },
                  child: rebateCalculationProvider.functionLoading
                      ? const LoadingWidget()
                      : const Text(
                          'তথ্য জমা দিন',
                          style: TextStyle(fontSize: TextSize.titleText),
                        ))
            ]),
          ),
        ),
      ),
    );
  }

  TableRow buildRow(String label, TextEditingController controller,{bool readOnly=false, bool requiredData=true}) {
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
