import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/feature/personal_info/provider/personal_info_provider.dart';
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
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
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
                                '2. Nation NID/passport (if there is no NID)',
                            hintText: 'Enter TIN',
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
                        TextFormFieldWidget(
                          controller: personalInfoProvider.circleController,
                          labelText: '4. Circle',
                          hintText: 'Enter circle',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.taxZoneController,
                          labelText: '5. Tax zone',
                          hintText: 'Enter TAX zone',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.assessmentYearController,
                          labelText: '6. Assessment year',
                          hintText: 'Enter assessment year',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        Text('7. Residential Status',
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: TextSize.bodyText)),
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
                        Text('8. Status of TAX payer',
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: TextSize.bodyText)),
                        Column(
                          children:
                              DummyData.statusOfTaxpayersList.map((String option) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(option),
                              value: option,
                              groupValue:
                                  personalInfoProvider.statusOfTaxpayersRadioValue,
                              onChanged:
                                  personalInfoProvider.changeClassOfTaxpayers,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text('9. Privileges of TAX payer',
                            style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: TextSize.bodyText)),
                        Column(
                          children: DummyData.taxpayerPrivilegesList
                              .map((String option) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(option),
                              value: option,
                              groupValue: personalInfoProvider
                                  .taxpayerPrivilegesRadioValue,
                              onChanged: (value) => personalInfoProvider
                                  .changeTaxpayerPrivileges(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: personalInfoProvider.dateOfBirthController,
                          labelText: '10. Date of birth',
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
                            labelText: '11. Name of spouse',
                            hintText: 'Enter name of spouse',
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.spouseTinController,
                            labelText: '12. TIN of spouse',
                            hintText: 'Enter TIN of spouse',
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller:
                              personalInfoProvider.contactAddressController,
                          labelText: '13. Address of contact',
                          hintText: 'Enter Address of contact',
                          required: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.telephoneController,
                            labelText: '14. Telephone',
                            hintText: 'Enter Telephone',
                            textInputType: TextInputType.phone),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.mobileController,
                            labelText: '15. Mobile number',
                            hintText: 'Enter Mobile number',
                            required: true,
                            textInputType: TextInputType.phone),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.emailController,
                            labelText: '16. Email address',
                            hintText: 'Enter email address',
                            required: true,
                            textInputType: TextInputType.emailAddress),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider
                                .currentlyWorkingOrgController,
                            labelText:
                                '17. If employed, employer’s name (latest employer’s name in case of multiple employment)',
                            hintText: 'Enter if employed, employer’s name (latest employer’s name in case of multiple employment)',
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.orgNameController,
                            labelText: '18. Organization name',
                            hintText: 'Enter Organization name',
                            required: true,
                            textCapitalization: TextCapitalization.words),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                            controller: personalInfoProvider.orgBinController,
                            labelText: '19. BIN of organization',
                            hintText: 'Enter BIN of organization',
                            required: true,
                            textInputType: TextInputType.number),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller:
                              personalInfoProvider.partnerNameAndTinController,
                          labelText:
                              '20. Name and TIN of Partners/Members in case of Firm/Association of Persons',
                          minLine: 2,
                          maxLine: 3,
                          hintText:
                              'Enter Name and TIN of Partners/Members in case of Firm/Association of Persons',
                          required: true,
                        ),
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
