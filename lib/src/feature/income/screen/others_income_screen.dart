import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/others_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class OthersIncomeScreen extends StatelessWidget {
  const OthersIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OthersIncomeProvider othersIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income from Others Sector',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await othersIncomeProvider.getOthersIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Form(
            key: othersIncomeProvider.othersIncomeKey,
            child: Column(children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  othersIncomeProvider.othersIncomeInputList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 24),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index != 0)
                        IconButton(
                            onPressed: () {
                              othersIncomeProvider
                                  .removeItemOfOthersIncomeInputList(index);
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

                          ///Table Row
                          TableRow(
                            children: [
                              TableTextFormFieldWidget(
                                controller: othersIncomeProvider
                                    .othersIncomeInputList[index]
                                    .particular!.description!,
                                textCapitalization: TextCapitalization.sentences,
                                maxLine: 5,
                                hintText: 'Particular',
                                required: true,
                              ),
                              TableTextFormFieldWidget(
                                controller: othersIncomeProvider
                                    .othersIncomeInputList[index]
                                    .particular!.amount!,
                                textInputType: TextInputType.number,
                                hintText: '0.00',
                              ),
                            ],
                          ),
                          buildRow(
                              "3. TDS Deducted",
                              othersIncomeProvider
                                  .othersIncomeInputList[index]
                                  .tdsDeducted!),
                          buildRow(
                              "4. Exempted if any",
                              othersIncomeProvider
                                  .othersIncomeInputList[index]
                                  .exemptedAmount!),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        othersIncomeProvider.addOthersInputListItem();
                      },
                      child: const Text('Add More'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await othersIncomeProvider
                        .submitOthersIncomeButtonOnTap();
                  },
                  child: othersIncomeProvider.functionLoading
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
