import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_color.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../provider/cost_information_provider.dart';

class CostInformationScreen extends StatelessWidget {
  const CostInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CostInformationProvider costInformationProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'ব্যয় এর তথ্য',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await costInformationProvider.getCostInfoData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: costInformationProvider.costInformationFormKey,
            child: Column(children: [
              TextFormFieldWidget(
                  controller: costInformationProvider.nameOfAssesseeController,
                  labelText: 'Name of assessee',
                  maxLine: 2,
                  hintText: 'Enter name of assessee',
                  required: true,
                  textCapitalization: TextCapitalization.words),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                  controller: costInformationProvider.tinController,
                  labelText: 'TIN',
                  hintText: 'Enter TIN',
                  required: true,
                  textInputType: TextInputType.number),
              const SizedBox(height: 20),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: costInformationProvider
                      .costInformationInputItemList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index != 0)
                            costInformationProvider.deleteButtonOnTap
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    onPressed: () {
                                      costInformationProvider
                                          .removeItemOfCostInformationInputList(
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
                                      'Particulars of Expenditure (Annual/yearly)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Amount ৳',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Comment',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              //Table Row

                              buildRow(
                                  "1. Personal and fooding expenses",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalAndFoodingExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalAndFoodingExpanses!
                                      .comment!),
                              buildRow(
                                  "2. Accommodation expenses",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .accommodationExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .accommodationExpanses!
                                      .comment!),
                              buildRow(
                                  "3. Personal Transport Expenses",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalTransportExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalTransportExpanses!
                                      .comment!),
                              buildRow(
                                  "4. Utility expenses (Electric bill, Gas, Water, Telephone, Mobile, Internet etc.)",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .utilityExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .utilityExpanses!
                                      .comment!),
                              buildRow(
                                  "5. Education Expenses",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .educationExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .educationExpanses!
                                      .comment!),
                              buildRow(
                                  "6. Personal Expenses for local & foreign travel, vacation etc.",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .personalExpanses!
                                      .comment!),
                              buildRow(
                                  "7. Festival and Other special expenses",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .festivalExpanses!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .festivalExpanses!
                                      .comment!),
                              buildRow(
                                  "8. Tax deducted/collected at source (with tax deducted from profit of saving certificate) and tax & surcharge paid based on last year tax return)",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .taxDeduction!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .taxDeduction!
                                      .comment!),
                              buildRow(
                                  "8. Interest paid on Personal loan (Institution & other source)",
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .interestPaid!
                                      .amount!,
                                  costInformationProvider
                                      .costInformationInputItemList[index]
                                      .interestPaid!
                                      .comment!),
                            ],
                          ),
                        ],
                      )),
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        costInformationProvider
                            .addCostInformationInputListItem();
                      },
                      child: const Text('আরেকটি বিবরনি যোগ'))),
              const SizedBox(height: 12),
              SolidButton(
                  onTap: () async {
                    await costInformationProvider.submitDataButtonOnTap();
                  },
                  child: costInformationProvider.functionLoading
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

  TableRow buildRow(String label, TextEditingController amountController,
      TextEditingController commentController,
      {bool readOnly = false, bool requiredData = true}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        TableTextFormFieldWidget(
          controller: amountController,
          textInputType: TextInputType.number,
          hintText: '0.00',
          required: requiredData,
        ),
        TableTextFormFieldWidget(
          controller: commentController,
          hintText: '',
          required: false,
        ),
      ],
    );
  }
}
