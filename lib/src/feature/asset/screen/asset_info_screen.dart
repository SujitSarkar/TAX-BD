import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/asset/provider/asset_info_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';

class AssetInfoScreen extends StatelessWidget {
  const AssetInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetInfoProvider assetInfoProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Asset Information',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await assetInfoProvider.getAssetInfoData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('To Whom It May Concern',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text(
                '• All Public Servants.\n'
                '• If the amount of Total Asset at home and abroad exceeds Taka 40,00,000\n'
                '• The amount of Total Asset does not exceed Tk. 40,00,000 but owns a Motor Car in any time or Invested in any House Property or Apartment within the City Corporation area or Owns Assets outside Bangladesh or being a Shareholder Director of a Company.\n'
                '• Every Non-Bangladeshi and Non-Resident Bangladesh Natural Person shall submit the statement only in respect of Assets Located in Bangladesh.',
                style: TextStyle(fontSize: TextSize.bodyText)),
            const SizedBox(height: 16),

            ///Source of fund
            const Text('1. Source of fund:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.grey),
              children: [
                //Table Row
                buildRow(
                    "(a) Total Income Shown in Return (Sl. No. 11 of Statement of Total Income)",
                    assetInfoProvider.sofTotalIncome,readOnly: true),
                buildRow("(b) Tax Exempted Income (Pls see Instruction Page)",
                    assetInfoProvider.sofTaxExemptedIncome,readOnly: true),
                buildRow("(c) Receipt of Gift and Others",
                    assetInfoProvider.sofReceiptOfGift),
                buildRow("Total Source of Fund (a+b+c)",
                    assetInfoProvider.totalSourceOfFund,
                    isBold: true, readOnly: true),

                buildRow(
                    "2. Net Wealth as on Last Date of Previous Income Year",
                    assetInfoProvider.netWealthOfPreviousIncomeYear),
                buildRow(
                    "3. Sum of Source of Fund and Previous Year’s Net Wealth (1+2)",
                    assetInfoProvider.sumOfSourceOfFound),
              ],
            ),
            const SizedBox(height: 20),

            ///Total Expense and Loss
            const Text('4. Expense and Loss:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.grey),
              children: [
                //Table Row
                buildRow("(a) Expense relating to Lifestyle (as per IT-10BB)",
                    assetInfoProvider.expenseOfLifestyle,readOnly: true),
                buildRow("(b) Gift / Expenses / Loss Not Mentioned  in IT-10BB",
                    assetInfoProvider.giftExpanseLoss),
                buildRow("Total Expense and Loss",
                    assetInfoProvider.totalExpanseAndLoss,
                    isBold: true, readOnly: true),

                buildRow(
                    "5. Net Wealth at the Last Date of this Financial Year (3–4)",
                    assetInfoProvider.netWealthLastDateOfFinancialYear,
                    readOnly: true),
              ],
            ),
            const SizedBox(height: 20),

            ///Personal Liabilities Outside Bangladesh
            const Text('6. Personal Liabilities Outside Bangladesh:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.grey),
              children: [
                //Table Row
                buildRow("(a) Institutional Liabilities",
                    assetInfoProvider.plobInstLiabilities),
                buildRow("(b) Non-Institutional Liabilities",
                    assetInfoProvider.plobNonInstLiabilities),
                buildRow("(c) Other Liabilities",
                    assetInfoProvider.plobOtherLiabilities),
                buildRow("Total Liabilities Outside Bangladesh",
                    assetInfoProvider.totalLiabilitiesOutsideBd,
                    isBold: true, readOnly: true),

                buildRow("7. Gross Wealth (5+6)", assetInfoProvider.grossWealth,
                    readOnly: true),
              ],
            ),
            const SizedBox(height: 20),

            ///Particulars of Assets
            const Text('8. Particulars of Assets:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.grey),
              children: [
                //Table Row
                buildRow("(a) Total Asset of Business (Less: Business Liabilities (Institutional & Non-Institutional) )",
                    assetInfoProvider.totalAssetOfBusiness,readOnly: true),

                buildRow("(b) Director’s Shareholdings in the Companies",
                    assetInfoProvider.directorShareholdings),
                buildRow("(c) Business Capital of Partnership Firm",
                    assetInfoProvider.businessCapitalOfPartnershipFirm),
                buildRow(
                    "(d) Non-Agricultural Property/land/House Property(Acquisition/Cost Value with Legal Expense/Acquired Price/Building Cost/Investment)Location and Description of Non-Agricultural Property(use separate sheet if needed)",
                    assetInfoProvider.nonAgriculturalProperty),
                buildRow(
                    "(e) Agricultural Property(Acquisition/Cost Value with Legal Expense)Location and Description of Non-Agricultural Property(use separate sheet if needed)",
                    assetInfoProvider.agriculturalProperty),

                ///Financial Asset
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('(f) Financial Assets:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(''),
                  ],
                ),
                buildRow("(i) Share/Debenture/Bond/Securities/Unit Certificate etc.",
                    assetInfoProvider.shareDebentureBondSecurities),
                buildRow("(ii) Sanchaypatra / Deposit Pension Scheme ",
                    assetInfoProvider.sanchaypatraDepositPensionScheme),
                buildRow("(iii)	Loan Given (Mention Name & NID of Loan Receiver)",
                    assetInfoProvider.loanGiven),
                buildRow("(iv) Savings Deposit / Term Deposit",
                    assetInfoProvider.savingsDeposit),
                buildRow("(v)	Provident Fund or Other Fund (if any)m",
                    assetInfoProvider.providentOrOtherFund),
                buildRow("(vi) Other Investment",
                    assetInfoProvider.otherInvestment),
                buildRow("Total Financial Asset:",
                    assetInfoProvider.totalFinancialAssets,readOnly: true,isBold: true),

                buildRow("(g)	Motor Vehicle(s)(Cost Value including Registration Expense)(Mention Type and Registration Number of Motor Vehicle)",
                    assetInfoProvider.motorVehicle),
                buildRow("(h)	Ornaments (Mention Quantity)",
                    assetInfoProvider.ornaments),
                buildRow("(i)	Furniture and Electronic Items",
                    assetInfoProvider.furnitureAndElectronicItems),
                buildRow("(j)	Other Assets (Except Assets Mentioned in Sl. k)",
                    assetInfoProvider.otherAsset),

                ///Cash in Hand and Fund Outside Business
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('(k) Cash in Hand and Fund Outside Business:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(''),
                  ],
                ),
                buildRow("(i) Bank Balance", assetInfoProvider.bankBalance),
                buildRow("(ii) Cash in Hand", assetInfoProvider.cashInHand),
                buildRow("(iii)	Others", assetInfoProvider.othersOfCashInHand),
                buildRow("Total Cash in Hand and Fund Outside Business",
                    assetInfoProvider.totalCashInHand,readOnly: true,isBold: true),

                buildRow("(9) Asset Outside BD", assetInfoProvider.assetOutsideBd),
                buildRow("(10) Total Assets in BD and Outside BD (8+9)", assetInfoProvider.totalAssetsInBdOutsideBd,readOnly: true),
              ],
            ),
            const SizedBox(height: 20),

            SolidButton(
                onTap: () async {
                  await assetInfoProvider.submitDataButtonOnTap();
                },
                child: assetInfoProvider.functionLoading
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
      {bool isBold = false, bool readOnly = false, bool requiredData = false}) {
    return TableRow(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label,
                style: TextStyle(fontWeight: isBold ? FontWeight.bold : null))),
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
