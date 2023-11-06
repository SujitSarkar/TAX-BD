import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/feature/personal_info/provider/personal_info_provider.dart';
import 'package:tax_bd/src/feature/personal_info/widget/radio_widget.dart';
import 'package:tax_bd/src/shared/widget/dropdown_button.dart';
import 'package:tax_bd/src/shared/widget/loading_widget.dart';
import 'package:tax_bd/src/shared/widget/solid_button.dart';
import 'package:tax_bd/src/shared/widget/text_field_widget.dart';
import '../../../constant/app_color.dart';
import '../../../constant/text_size.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalInfoProvider personalInfoProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Personal Information',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: personalInfoProvider.loading
          ? const LoadingWidget(color: AppColor.primaryColor)
          : RefreshIndicator(
        onRefresh: ()async=> await personalInfoProvider.getUserData(),
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Form(
                  key: personalInfoProvider.personalInfoFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldWidget(
                            controller: personalInfoProvider.nameController,
                            labelText: '1. Name of TAX payer',
                            hintText: 'Name of TAX payer',
                            required: true,
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller:
                                personalInfoProvider.nidOrPassportController,
                            labelText:
                                '2. Nation NID/Passport (if there is no NID)',
                            hintText: 'Enter Nation NID/Passport',
                            required: true,
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.tinController,
                            labelText: '3. TIN',
                            hintText: 'Enter TIN',
                            required: true,
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),

                        CustomDropdown(items: DummyData.incomeSourceLocationList,
                            selectedValue: personalInfoProvider.incomeSourceLocationDropdownValue,
                            labelText: '4. Location of main source of income',
                            onChanged: personalInfoProvider.changeTaxpayerArea),
                        const SizedBox(height: 16),

                        TextFormFieldWidget(
                          controller: personalInfoProvider.circleController,
                          labelText: '5. Circle',
                          hintText: 'Enter circle',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.taxZoneController,
                          labelText: '6. Tax zone',
                          hintText: 'Enter TAX zone',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.assessmentYearController,
                          labelText: '7. Assessment year',
                          hintText: 'Enter assessment year',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        Text('8. Gender',
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                        Column(
                          children: DummyData.genderList
                              .map((String option) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(option),
                              value: option,
                              groupValue: personalInfoProvider
                                  .genderRadioValue,
                              onChanged:
                              personalInfoProvider.changeGender,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text('9. Residential Status',
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
                        Column(
                          children: DummyData.residentialStatusList
                              .map((String option) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(option),
                              value: option,
                              groupValue: personalInfoProvider
                                  .residentialStatusRadioValue,
                              onChanged:
                                  personalInfoProvider.changeResidentialStatus,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        CustomDropdown(items: DummyData.statusOfTaxpayersList,
                            selectedValue: personalInfoProvider.statusOfTaxpayersDropdownValue,
                            labelText: '10. Status of TAX payer', onChanged: personalInfoProvider.changeStatusOfTaxpayers),
                        const SizedBox(height: 16),
                        CustomDropdown(items: DummyData.taxpayerPrivilegesList,
                            selectedValue: personalInfoProvider.taxpayerPrivilegesDropdownValue,
                            labelText: '11. Privileges of TAX payer', onChanged: personalInfoProvider.changeTaxpayerPrivileges),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.dateOfBirthController,
                          labelText: '12. Date of birth',
                          hintText: 'Enter date of birth',
                          required: true,
                          readOnly: true,
                          onTap: ()async{
                            await personalInfoProvider.selectDateOfBirth();
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.spouseController,
                            labelText: '13. Name of spouse',
                            hintText: 'Enter name of spouse',
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.spouseTinController,
                            labelText: '14. TIN of spouse',
                            hintText: 'Enter TIN of spouse',
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller:
                              personalInfoProvider.contactAddressController,
                          labelText: '15. Address of contact',
                          hintText: 'Enter Address of contact',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.telephoneController,
                            labelText: '16. Telephone',
                            hintText: 'Enter Telephone',
                            textInputType: TextInputType.phone),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.mobileController,
                            labelText: '17. Mobile number',
                            hintText: 'Enter Mobile number',
                            required: true,
                            readOnly: true,
                            textInputType: TextInputType.phone),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.emailController,
                            labelText: '18. Email address',
                            hintText: 'Enter email address',
                            required: true,
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider
                                .currentlyWorkingOrgController,
                            labelText:
                                '19. If employed, employer’s name (latest employer’s name in case of multiple employment)',
                            hintText: 'Enter if employed, employer’s name (latest employer’s name in case of multiple employment)',
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.orgNameController,
                            labelText: '20. Organization name',
                            hintText: 'Enter Organization name',
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.orgBinController,
                            labelText: '21. BIN of organization',
                            hintText: 'Enter BIN of organization',
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller:
                              personalInfoProvider.partnerNameAndTinController,
                          labelText:
                              '22. Name and TIN of Partners/Members in case of Firm/Association of Persons',
                          minLine: 2,
                          maxLine: 3,
                          hintText: 'Enter Name and TIN of Partners/Members in case of Firm/Association of Persons',
                        ),
                        const SizedBox(height: 16),
                       PersonalInfoRadioWidget(
                         title: '23. Claim tax rebate for investment?',
                         groupValue: personalInfoProvider.claimTaxRebate,
                         onChanged: personalInfoProvider.changeClaimTaxRebate,
                       ),
                       const SizedBox(height: 16),
                        PersonalInfoRadioWidget(
                          title: '24. Shareholder director of a company?',
                          groupValue: personalInfoProvider.shareholderDirector,
                          onChanged: personalInfoProvider.changeShareholderDirector,
                        ),
                        const SizedBox(height: 16),

                        const Text('IT10B Requirements',style: TextStyle(fontSize: TextSize.titleText,fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),

                        PersonalInfoRadioWidget(
                          title: '25. Gross wealth over 4000000',
                          groupValue: personalInfoProvider.grossWealthOver,
                          onChanged: personalInfoProvider.changeGrossWealthOver,
                        ),
                        const SizedBox(height: 16),
                        PersonalInfoRadioWidget(
                          title: '26. Own motor car?',
                          groupValue: personalInfoProvider.ownMotorCar,
                          onChanged: personalInfoProvider.changeOwnMotorcar,
                        ),
                        const SizedBox(height: 16),
                        PersonalInfoRadioWidget(
                          title: '27. Own offshore property?',
                          groupValue: personalInfoProvider.ownOffshoreProperty,
                          onChanged: personalInfoProvider.changeOwnOffshoreProperty,
                        ),
                        const SizedBox(height: 16),
                        PersonalInfoRadioWidget(
                          title: '28. Have house property in any city corporation?',
                          groupValue: personalInfoProvider.housePropertyInCityCorp,
                          onChanged: personalInfoProvider.changeHousePropertyInCityCorp,
                        ),
                        const SizedBox(height: 16),


                        const SizedBox(height: 20),
                        SolidButton(
                            onTap: () async {
                              await personalInfoProvider.submitDataButtonOnTap();
                            },
                            child: personalInfoProvider.functionLoading
                                ? const LoadingWidget()
                                : const Text(
                                    'Submit Data',
                                    style:
                                        TextStyle(fontSize: TextSize.buttonText),
                                  ))
                      ]),
                ),
              ),
          ),
    );
  }
}
