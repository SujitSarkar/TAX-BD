import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/dummy_data.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/dropdown_button.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/table_text_field_widget.dart';
import '../../../shared/widget/text_field_widget.dart';

class PrivateSalaryIncomeScreen extends StatelessWidget {
  const PrivateSalaryIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Private Salary Income',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            await salaryIncomeProvider.getPrivateSalaryIncomeData(),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(children: [
            const Text(
                'This part is applicable for employees other then Govt. pay scale',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    salaryIncomeProvider.privateSalaryIncomeInputList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0)
                          IconButton(
                              onPressed: () {
                                salaryIncomeProvider
                                    .removeItemOfPrivateSalaryIncomeInputList(
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
                                    'Particulars',
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
                                "1. Basic Salary",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .basicSalary!),
                            buildRow(
                                "2. House Rent Allowances",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .houseRentAllowance!),
                            buildRow(
                                "3. Medical Allowances",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .medicalAllowance!),
                            buildRow(
                                "4. Conveyance Allowance",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .conveyanceAllowance!),
                            buildRow(
                                "5. Festival Bonus",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .festivalBonus!),
                            buildRow(
                                "6. Others",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .others!),

                            buildRow(
                                "15. Total income from salary (1+2+3+4+5+6)",
                                salaryIncomeProvider
                                    .privateSalaryIncomeInputList[index]
                                    .totalIncomeFromSalary!,
                                readOnly: true,isBold: true)
                          ],
                        ),
                        const SizedBox(height: 12),

                        CheckboxListTile(
                            title: const Text('Rent Free Accommodation',
                                style: TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: salaryIncomeProvider
                                .privateSalaryIncomeInputList[index]
                                .rentFreeAccommodation!, onChanged: (newValue){
                          salaryIncomeProvider.changeRentFreeAccommodation(index, newValue as bool);
                        }),
                        if(salaryIncomeProvider.privateSalaryIncomeInputList[index]
                            .rentFreeAccommodation!)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .rentFreeAccommodationValue!,
                                  labelText: 'Value of Accommodation',
                                  hintText: 'Enter Value of Accommodation',
                                  textInputType: TextInputType.number),
                              const SizedBox(height: 12),
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .rentFreeAccommodationMonth!,
                                  labelText: 'Month',
                                  hintText: 'Enter Month',
                                  textInputType: TextInputType.number),
                            ],
                          ),
                        const SizedBox(height: 12),

                        CheckboxListTile(
                            title: const Text('Accommodation at Concessional Rate',
                                style: TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: salaryIncomeProvider
                                .privateSalaryIncomeInputList[index]
                                .accommodationAtConcessionalRate, onChanged: (newValue){
                          salaryIncomeProvider.changeAccommodationConcessionalRate(index, newValue as bool);
                        }),
                        if(salaryIncomeProvider.privateSalaryIncomeInputList[index]
                            .accommodationAtConcessionalRate!)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .concessionalRateValue!,
                                  labelText: 'Value of Accommodation',
                                  hintText: 'Enter Value of Accommodation',
                                  textInputType: TextInputType.number),
                              const SizedBox(height: 12),
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .rentPaidByTaxpayer!,
                                  labelText: 'Rent Paid by the Taxpayer',
                                  hintText: 'Enter Rent Paid by the Taxpayer',
                                  textInputType: TextInputType.number),
                              const SizedBox(height: 12),
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .concessionalRateMonth!,
                                  labelText: 'Month',
                                  hintText: 'Enter Month',
                                  textInputType: TextInputType.number),
                            ],
                          ),
                        const SizedBox(height: 12),

                        CheckboxListTile(
                            title: const Text('Vehicle Facility Provided',
                                style: TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: salaryIncomeProvider
                                .privateSalaryIncomeInputList[index]
                                .vehicleFacilityProvided, onChanged: (newValue){
                          salaryIncomeProvider.changeVehicleFacilityProvided(index, newValue as bool);
                        }),
                        if(salaryIncomeProvider.privateSalaryIncomeInputList[index]
                            .vehicleFacilityProvided!)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropdown(items: DummyData.vehicleCCList,
                                  selectedValue: salaryIncomeProvider.privateSalaryIncomeInputList[index].vehicleCC,
                                  labelText: 'Select CC limit', onChanged:(newValue){
                                    salaryIncomeProvider.changeVehicleCCLimit(index,newValue);
                                  }),
                              const SizedBox(height: 12),
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .vehicleFacilityMonth!,
                                  labelText: 'Month',
                                  hintText: 'Enter Month',
                                  textInputType: TextInputType.number),
                            ],
                          ),
                        const SizedBox(height: 12),

                        CheckboxListTile(
                            title: const Text('Other Non-Cash Benefit',
                                style: TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: salaryIncomeProvider
                                .privateSalaryIncomeInputList[index]
                                .hasOtherNonCashBenefit, onChanged: (newValue){
                          salaryIncomeProvider.changeOtherNonCashBenefit(index, newValue as bool);
                        }),
                        if(salaryIncomeProvider.privateSalaryIncomeInputList[index]
                            .hasOtherNonCashBenefit!)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .otherNonCashBenefit!.particular!,
                                  labelText: 'Particular',
                                  hintText: 'Enter Particular',
                                  textCapitalization: TextCapitalization.sentences),
                              const SizedBox(height: 12),
                              TextFormFieldWidget(
                                  controller: salaryIncomeProvider.privateSalaryIncomeInputList[index]
                                      .otherNonCashBenefit!.value!,
                                  labelText: 'Value',
                                  hintText: 'Enter Value',
                                  textInputType: TextInputType.number),
                            ],
                          ),
                        const SizedBox(height: 12),
                      ],
                    )),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      salaryIncomeProvider
                          .addPrivateSalaryIncomeInputListItem();
                    },
                    child: const Text('Add More'))),
            const SizedBox(height: 12),
            SolidButton(
                onTap: () async {
                  await salaryIncomeProvider
                      .submitPrivateSalaryIncomeButtonOnTap();
                },
                child: salaryIncomeProvider.functionLoading
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
      {bool readOnly = false, bool requiredData = false,bool isBold = false}) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label,style: TextStyle(fontWeight: isBold?FontWeight.bold:null))),
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
