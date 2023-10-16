import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/app_color.dart';
import 'package:tax_bd/src/feature/income/provider/financial_asset_income_provider.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/solid_button.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class FinancialAssetIncomeScreen extends StatelessWidget {
  const FinancialAssetIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FinancialAssetIncomeProvider financialAssetIncomeProvider =
        Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income from Financial Asset',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async=>await financialAssetIncomeProvider.getFinancialAssetIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 12,right: 12, bottom: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///FDR Form
            const Text('Income from FDR',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: TextSize.titleText,color: AppColor.primaryColor)),
            const SizedBox(height: 12),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: financialAssetIncomeProvider.fdrIncomeItemList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                financialAssetIncomeProvider
                                    .removeFdrIncomeListItem(index);
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
                            buildRow(
                                "1. FDR No",
                                financialAssetIncomeProvider
                                    .fdrIncomeItemList[index].fdrNo!),
                            buildRow(
                                "2. Amount in investment",
                                financialAssetIncomeProvider
                                    .fdrIncomeItemList[index].investmentFigure!),
                            buildRow(
                                "3. Profit received",
                                financialAssetIncomeProvider
                                    .fdrIncomeItemList[index].profitReceived!),
                            buildRow(
                                "4. Source tax",
                                financialAssetIncomeProvider
                                    .fdrIncomeItemList[index].sourceTax!),
                          ],
                        ),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      financialAssetIncomeProvider.addFdrIncomeListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 20),

            ///DPS Form
            const Text('Income from DPS',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: TextSize.titleText,color: AppColor.primaryColor)),
            const SizedBox(height: 12),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: financialAssetIncomeProvider.dpsIncomeItemList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0)
                      IconButton(
                          onPressed: () {
                            financialAssetIncomeProvider
                                .removeDpsIncomeListItem(index);
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
                        buildRow(
                            "1. DPS No",
                            financialAssetIncomeProvider
                                .dpsIncomeItemList[index].dpsNo!),
                        buildRow(
                            "2. Total deposit amount",
                            financialAssetIncomeProvider
                                .dpsIncomeItemList[index].totalDepositAmount!),
                        buildRow(
                            "3. Profit received",
                            financialAssetIncomeProvider
                                .dpsIncomeItemList[index].profitReceived!),
                        buildRow(
                            "4. Source tax",
                            financialAssetIncomeProvider
                                .dpsIncomeItemList[index].sourceTax!),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      financialAssetIncomeProvider.addDpsIncomeListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 20),

            ///Income from bank account Form
            const Text('Income from bank account',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: TextSize.titleText,color: AppColor.primaryColor)),
            const SizedBox(height: 12),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: financialAssetIncomeProvider.incomeFromBankItemList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0)
                      IconButton(
                          onPressed: () {
                            financialAssetIncomeProvider
                                .removeIncomeFromBankListItem(index);
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
                        buildRow(
                            "1. Bank account no",
                            financialAssetIncomeProvider
                                .incomeFromBankItemList[index].bankAccountNo!),

                        buildRow(
                            "2. Profit received",
                            financialAssetIncomeProvider
                                .incomeFromBankItemList[index].profitReceived!),
                        buildRow(
                            "3. Source tax",
                            financialAssetIncomeProvider
                                .incomeFromBankItemList[index].sourceTax!),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      financialAssetIncomeProvider.addIncomeFromBankListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 20),

            ///Insurance profits Form
            const Text('Insurance profits',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: TextSize.titleText,color: AppColor.primaryColor)),
            const SizedBox(height: 12),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: financialAssetIncomeProvider.insuranceProfitItemList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0)
                      IconButton(
                          onPressed: () {
                            financialAssetIncomeProvider
                                .removeInsuranceProfitListItem(index);
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
                        buildRow(
                            "1. Insurance policy no",
                            financialAssetIncomeProvider
                                .insuranceProfitItemList[index].insurancePolicyNo!),
                        buildRow(
                            "2. Premium deposit",
                            financialAssetIncomeProvider
                                .insuranceProfitItemList[index].premiumDeposit!),
                        buildRow(
                            "3. Profit received",
                            financialAssetIncomeProvider
                                .insuranceProfitItemList[index].profitReceived!),
                        buildRow(
                            "4. Source tax",
                            financialAssetIncomeProvider
                                .insuranceProfitItemList[index].sourceTax!),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      financialAssetIncomeProvider.addInsuranceProfitListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 20),

            ///Others Form
            const Text('Others',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: TextSize.titleText,color: AppColor.primaryColor)),
            const SizedBox(height: 12),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: financialAssetIncomeProvider.othersProfitItemList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index != 0)
                      IconButton(
                          onPressed: () {
                            financialAssetIncomeProvider
                                .removeOthersProfitListItem(index);
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
                        buildRow(
                            "1. Investment details",
                            financialAssetIncomeProvider
                                .othersProfitItemList[index].investmentDetails!),
                        buildRow(
                            "2. Amount of investment",
                            financialAssetIncomeProvider
                                .othersProfitItemList[index].amountOfInvestment!),
                        buildRow(
                            "3. Profit received",
                            financialAssetIncomeProvider
                                .othersProfitItemList[index].profitReceived!),
                        buildRow(
                            "4. Source tax",
                            financialAssetIncomeProvider
                                .othersProfitItemList[index].sourceTax!),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      financialAssetIncomeProvider.addOthersProfitListItem();
                    },
                    child: const Text('Add More'))),

            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await financialAssetIncomeProvider
                      .submitFinancialAssetIncomeButtonOnTap();
                },
                child: financialAssetIncomeProvider.functionLoading
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
