import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/capital_gain_income_provider.dart';

class CapitalGainIncomeScreen extends StatelessWidget {
  const CapitalGainIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CapitalGainIncomeProvider capitalGainIncomeProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income of Capital Gain',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await capitalGainIncomeProvider.getCapitalGainIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: capitalGainIncomeProvider.capitalGainKey,
            child: Column(children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      capitalGainIncomeProvider.capitalGainIncomeInputList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index != 0)
                            IconButton(
                                onPressed: () {
                                  capitalGainIncomeProvider
                                      .removeItemOfCapitalGainIncomeInputList(
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
                                      'Summary of Income',
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
                              ///Table Row
                              TableRow(
                                children: [
                                  TableTextFormFieldWidget(
                                    controller: capitalGainIncomeProvider
                                        .capitalGainIncomeInputList[index]
                                        .particular!.description!,
                                    textCapitalization: TextCapitalization.sentences,
                                    maxLine: 5,
                                    hintText: 'Particular',
                                    required: true,
                                  ),
                                  TableTextFormFieldWidget(
                                    controller: capitalGainIncomeProvider
                                        .capitalGainIncomeInputList[index]
                                        .particular!.amount!,
                                    textInputType: TextInputType.number,
                                    hintText: '0.00',
                                  ),
                                ],
                              ),
                              buildRow(
                                  "2. Acquisition Date",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index]
                                      .acquisitionDateText!,
                                  readOnly: true, onTap: () {
                                capitalGainIncomeProvider
                                    .selectAcquisitionDate(index);
                              }),
                              buildRow(
                                  "3. Sales Date",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index]
                                      .salesDateText!,
                                  readOnly: true, onTap: () {
                                capitalGainIncomeProvider.selectSalesDate(index);
                              }),

                              buildRow(
                                  "4. Sales",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index].sales!),
                              buildRow(
                                  "5. Acquisition Cost",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index]
                                      .acquisitionValue!),
                              buildRow(
                                  "6. Sales Cost",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index]
                                      .salesCost!),
                              buildRow(
                                  "7. Gain (4-5-6)",
                                  capitalGainIncomeProvider
                                      .capitalGainIncomeInputList[index].gain!,
                                  readOnly: true),
                            ],
                          ),
                        ],
                      )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        capitalGainIncomeProvider.addCapitalGainInputListItem();
                      },
                      child: const Text('Add More'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await capitalGainIncomeProvider
                        .submitCapitalGainIncomeButtonOnTap();
                  },
                  child: capitalGainIncomeProvider.functionLoading
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

  TableRow buildRow(String label, TextEditingController controller,
      {bool readOnly = false, bool requiredData = false, Function()? onTap}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        TableTextFormFieldWidget(
          controller: controller,
          textInputType: TextInputType.number,
          hintText: '0.00',
          readOnly: readOnly,
          required: requiredData,
          onTap: onTap,
        ),
      ],
    );
  }
}
