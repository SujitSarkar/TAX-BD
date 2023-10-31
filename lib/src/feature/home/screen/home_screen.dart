import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/constant/text_size.dart';
import 'package:tax_bd/src/feature/asset/provider/asset_info_provider.dart';
import 'package:tax_bd/src/feature/auth/repository/auth_repository.dart';
import 'package:tax_bd/src/feature/income/provider/agricultural_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/capital_gain_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/financial_asset_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/foreign_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/others_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/partnership_business_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/rental_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/salary_income_provider.dart';
import 'package:tax_bd/src/feature/income/provider/spouse_children_income_provider.dart';
import 'package:tax_bd/src/feature/rebate/provider/rebate_calculation_provider.dart';
import 'package:tax_bd/src/feature/tax/provider/tax_calculation_provider.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/shared/app_navigator_key.dart';
import 'package:tax_bd/src/shared/widget/normal_card.dart';
import '../../expanse/provider/expense_information_provider.dart';
import '../../personal_info/provider/personal_info_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> onInit()async{
    final BuildContext context = AppNavigatorKey.key.currentState!.context;
    final PersonalInfoProvider personalInfoProvider = Provider.of(context,listen: false);
    final RebateCalculationProvider rebateCalculationProvider = Provider.of(context,listen: false);
    final ExpenseInformationProvider expenseInformationProvider = Provider.of(context,listen: false);
    final TaxCalculationProvider taxCalculationProvider = Provider.of(context,listen: false);
    final SalaryIncomeProvider salaryIncomeProvider = Provider.of(context,listen: false);
    final RentalIncomeProvider rentalIncomeProvider = Provider.of(context,listen: false);
    final AgriculturalIncomeProvider agriculturalIncomeProvider = Provider.of(context,listen: false);
    final BusinessIncomeProvider businessIncomeProvider = Provider.of(context,listen: false);
    final FinancialAssetIncomeProvider financialAssetIncomeProvider = Provider.of(context,listen: false);
    final OthersIncomeProvider othersIncomeProvider = Provider.of(context,listen: false);
    final SpouseChildrenIncomeProvider spouseChildrenIncomeProvider = Provider.of(context,listen: false);
    final ForeignIncomeProvider foreignIncomeProvider = Provider.of(context,listen: false);
    final PartnershipBusinessIncomeProvider partnershipBusinessIncomeProvider = Provider.of(context,listen: false);
    final CapitalGainIncomeProvider capitalGainIncomeProvider = Provider.of(context,listen: false);
    final AssetInfoProvider assetInfoProvider = Provider.of(context,listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await Future.wait([
        rebateCalculationProvider.getRebateCalculationData(),
        salaryIncomeProvider.getPrivateSalaryIncomeData(),
        salaryIncomeProvider.getGovtSalaryIncomeData(),
        rentalIncomeProvider.getRentalIncomeData(),
        agriculturalIncomeProvider.getAgricultureIncomeData(),
        businessIncomeProvider.getBusinessIncomeData(),
        financialAssetIncomeProvider.getFinancialAssetIncomeData(),
        othersIncomeProvider.getOthersIncomeData(),
        spouseChildrenIncomeProvider.getSpouseChildrenIncomeData(),
        foreignIncomeProvider.getForeignIncomeData(),
        partnershipBusinessIncomeProvider.getPartnershipBusinessIncomeData(),
        capitalGainIncomeProvider.getCapitalGainIncomeData(),
      ]);

      await Future.wait([
        taxCalculationProvider.getTaxCalculationData(),
        personalInfoProvider.getUserData(),
        expenseInformationProvider.getCostInfoData(),
      ]);
      await assetInfoProvider.getAssetInfoData();
      await taxCalculationProvider.getTaxCalculationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async{
                await AuthRepository().logout();
              },
              splashRadius: 24,
              tooltip: 'Logout',
              icon: const Icon(LineAwesomeIcons.alternate_sign_out,color: Colors.red))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/image/logo_trans.png', height: 60, width: 60),
                const SizedBox(width: 12),
                const Text(
                  'TAX BD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.titleText),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: DummyData.homeDataList.length,
                itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NormalCard(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Navigator.pushNamed(
                                      context, AppRouter.personalInfoScreen);
                                case 1:
                                  Navigator.pushNamed(
                                      context, AppRouter.incomeInfoScreen);
                                  break;
                                case 2:
                                  Navigator.pushNamed(
                                      context, AppRouter.taxCalculationScreen);
                                case 3:
                                  Navigator.pushNamed(
                                      context, AppRouter.rebateCalculationScreen);
                                  break;
                                case 4:
                                  Navigator.pushNamed(
                                      context, AppRouter.assetInfoScreen);
                                  break;
                                case 5:
                                  Navigator.pushNamed(
                                      context, AppRouter.expenseInformationScreen);
                                  break;
                              }
                            },
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              DummyData.homeDataList[index].icon,
                              size: size.width * .15,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            DummyData.homeDataList[index].title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: TextSize.homeCardTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
