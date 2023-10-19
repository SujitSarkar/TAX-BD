import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/foreign_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class ForeignIncomeScreen extends StatelessWidget {
  const ForeignIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForeignIncomeProvider foreignIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Foreign Income',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await foreignIncomeProvider.getForeignIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: foreignIncomeProvider.foreignIncomeKey,
            child: Column(children: [
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  foreignIncomeProvider.foreignIncomeInputList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 24),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index != 0)
                        IconButton(
                            onPressed: () {
                              foreignIncomeProvider
                                  .removeItemOfForeignIncomeInputList(index);
                            },
                            icon: const Icon(Icons.cancel_rounded,
                                color: Colors.grey),
                            splashRadius: 25,
                            padding: EdgeInsets.zero),

                      CheckboxListTile(
                        title: const Text('Brought through proper banking channel or not',style: TextStyle(fontSize: TextSize.bodyText)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          value: foreignIncomeProvider
                          .foreignIncomeInputList[index].throughBankingChannel, onChanged: (newValue){
                        foreignIncomeProvider.changeBankingChannelOrNot(index, newValue as bool);
                      }),
                      const SizedBox(height: 12),

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
                                controller: foreignIncomeProvider
                                    .foreignIncomeInputList[index]
                                    .particular!.description!,
                                textCapitalization: TextCapitalization.sentences,
                                maxLine: 5,
                                hintText: 'Particular',
                                required: true,
                              ),
                              TableTextFormFieldWidget(
                                controller: foreignIncomeProvider
                                    .foreignIncomeInputList[index]
                                    .particular!.amount!,
                                textInputType: TextInputType.number,
                                hintText: '0.00',
                              ),
                            ],
                          ),
                          foreignIncomeProvider
                              .foreignIncomeInputList[index]
                              .throughBankingChannel?
                            buildRow(
                                "2. Exempted",
                                foreignIncomeProvider
                                    .foreignIncomeInputList[index]
                                    .exemptedAmount!,readOnly: true):const TableRow(children: [Text(''),Text('')]),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        foreignIncomeProvider.addForeignInputListItem();
                      },
                      child: const Text('Add More'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await foreignIncomeProvider
                        .submitForeignIncomeButtonOnTap();
                  },
                  child: foreignIncomeProvider.functionLoading
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
