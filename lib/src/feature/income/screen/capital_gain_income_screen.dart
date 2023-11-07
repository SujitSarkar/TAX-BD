import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import '../../../constant/dummy_data.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/dropdown_button.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/text_field_widget.dart';
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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                          const SizedBox(height: 12),

                          CustomDropdown(items: DummyData.capitalGainCategoryList,
                              selectedValue: capitalGainIncomeProvider.capitalGainIncomeInputList[index].typeOfGains,
                              labelText: 'Type of Gains', onChanged: (newValue){
                                capitalGainIncomeProvider.changeTypeOfGains(index, newValue);
                              }),
                          capitalGainIncomeProvider.capitalGainIncomeInputList[index].typeOfGains == DummyData.capitalGainCategoryList.first
                              ? _landWidget(capitalGainIncomeProvider,index)
                              : capitalGainIncomeProvider.capitalGainIncomeInputList[index].typeOfGains == DummyData.capitalGainCategoryList[1]
                              ? _homeApartmentWidget(capitalGainIncomeProvider,index)
                              : capitalGainIncomeProvider.capitalGainIncomeInputList[index].typeOfGains == DummyData.capitalGainCategoryList.last
                              ? _othersWidget(capitalGainIncomeProvider,index)
                              : const SizedBox.shrink()

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

  Widget _landWidget(CapitalGainIncomeProvider capitalGainIncomeProvider, int index)=>Column(children: [
    const SizedBox(height: 24),
    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].description!,
        labelText: '1. Description of the Property',
        hintText: 'Enter Description of the Property',
        textCapitalization: TextCapitalization.sentences),
    const SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormFieldWidget(
              controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].area!,
              labelText: '2. Total Area',
              hintText: 'Enter Total Area',
              textInputType: TextInputType.number),
        ),
        const SizedBox(width: 10),
        Expanded(child:  CustomDropdown(items: DummyData.areaUnitList,
            selectedValue: capitalGainIncomeProvider.capitalGainIncomeInputList[index].areaUnit,
            buttonHeight: 40,
            dropdownWidth: 120,
            labelText: 'Unit', onChanged: (newValue){
              capitalGainIncomeProvider.changeAreaUnit(index, newValue);
            }))
      ],
    ),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].tinOfBuyer!,
        labelText: '3. TIN of Buyer',
        hintText: 'Enter TIN of Buyer',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].deedNo!,
        labelText: '4. Deed No',
        hintText: 'Enter Deed No',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
      controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].dateOfDeedText!,
      labelText: '5. Date of Deed',
      hintText: 'Enter date of Deed',
      readOnly: true,
      onTap: ()async{
        await capitalGainIncomeProvider.selectDateOfDeed(index);
      },
    ),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].subRegistrarOffice!,
        labelText: '6. Sub Registrar Office',
        hintText: 'Enter Sub Registrar Office',
        textCapitalization: TextCapitalization.sentences),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].saleDeedValue!,
        labelText: '7. Sale Deed Value',
        hintText: 'Enter Sale Deed Value',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].costOfAcquisition!,
        labelText: '8. Cost of Acquisition',
        hintText: 'Enter Cost of Acquisition',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].capitalGain!,
        labelText: '9. Capital Gain (7-8)',
        hintText: '0.0',
        readOnly: true,
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].taxDeductedCollectedAtSource!,
        labelText: '10. Tax Deducted/Collected at Source',
        hintText: 'Enter Tax Deducted/Collected at Source',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),
  ]);

  Widget _homeApartmentWidget(CapitalGainIncomeProvider capitalGainIncomeProvider, int index)=>Column(children: [
    const SizedBox(height: 24),
    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].description!,
        labelText: '1. Description of the Property',
        hintText: 'Enter Description of the Property',
        textCapitalization: TextCapitalization.sentences),
    const SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormFieldWidget(
              controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].area!,
              labelText: '2. Land Area',
              hintText: 'Enter Land Area',
              textInputType: TextInputType.number),
        ),
        const SizedBox(width: 10),
        Expanded(child:  CustomDropdown(items: DummyData.areaUnitList,
            selectedValue: capitalGainIncomeProvider.capitalGainIncomeInputList[index].areaUnit,
            buttonHeight: 40,
            dropdownWidth: 120,
            labelText: 'Unit', onChanged: (newValue){
              capitalGainIncomeProvider.changeAreaUnit(index, newValue);
            }))
      ],
    ),
    const SizedBox(height: 16),

    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormFieldWidget(
              controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].flatBuildingArea!,
              labelText: '3. Flat/Building Area',
              hintText: 'Enter Flat/Building Area',
              textInputType: TextInputType.number),
        ),
        const SizedBox(width: 10),
        Expanded(child:  CustomDropdown(items: DummyData.buildingUnitList,
            selectedValue: capitalGainIncomeProvider.capitalGainIncomeInputList[index].flatBuildingUnit,
            buttonHeight: 40,
            dropdownWidth: 120,
            labelText: 'Unit', onChanged: (newValue){
              capitalGainIncomeProvider.changeFlatBuildingUnit(index, newValue);
            }))
      ],
    ),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].tinOfBuyer!,
        labelText: '4. TIN of Buyer',
        hintText: 'Enter TIN of Buyer',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].deedNo!,
        labelText: '5. Deed No',
        hintText: 'Enter Deed No',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
      controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].dateOfDeedText!,
      labelText: '6. Date of Deed',
      hintText: 'Enter date of Deed',
      readOnly: true,
      onTap: ()async{
        await capitalGainIncomeProvider.selectDateOfDeed(index);
      },
    ),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].subRegistrarOffice!,
        labelText: '7. Sub Registrar Office',
        hintText: 'Enter Sub Registrar Office',
        textCapitalization: TextCapitalization.sentences),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].saleDeedValue!,
        labelText: '8. Sale Deed Value',
        hintText: 'Enter Sale Deed Value',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].costOfAcquisition!,
        labelText: '9. Cost of Acquisition',
        hintText: 'Enter Cost of Acquisition',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].capitalGain!,
        labelText: '10. Capital Gain (8-9)',
        hintText: '0.0',
        readOnly: true,
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].taxDeductedCollectedAtSource!,
        labelText: '11. Tax Deducted/Collected at Source',
        hintText: 'Enter Tax Deducted/Collected at Source',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),
  ]);

  Widget _othersWidget(CapitalGainIncomeProvider capitalGainIncomeProvider, int index)=>Column(children: [
    const SizedBox(height: 24),
    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].description!,
        labelText: '1. Description of the Property',
        hintText: 'Enter Description of the Property',
        textCapitalization: TextCapitalization.sentences),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].acquisitionDateText!,
        labelText: '2. Acquisition Date',
        hintText: 'Enter Acquisition Date',
        readOnly: true,
        onTap: ()async{
          await capitalGainIncomeProvider.selectAcquisitionDate(index);
        },),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].salesDateText!,
        labelText: '3. Sales Date',
        hintText: 'Enter Sales Date',
        readOnly: true,
        onTap: ()async{
          await capitalGainIncomeProvider.selectSalesDate(index);
        },),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].salesValue!,
        labelText: '4. Sales Value',
        hintText: 'Enter Sales Value',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].costOfAcquisition!,
        labelText: '5. Cost of Acquisition',
        hintText: 'Enter Cost of Acquisition',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].costOfSales!,
        labelText: '6. Cost of Sales',
        hintText: 'Enter Cost of Sales',
        textInputType: TextInputType.number),
    const SizedBox(height: 16),

    TextFormFieldWidget(
        controller: capitalGainIncomeProvider.capitalGainIncomeInputList[index].capitalGain!,
        labelText: '7. Capital Gain (4-5-6)',
        hintText: '0.0',
        readOnly: true,
        textInputType: TextInputType.number),
    const SizedBox(height: 16),
  ]);
}
