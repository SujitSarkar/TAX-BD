import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tax_bd/src/feature/income/widget/income_category_widget.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/shared/widget/normal_card.dart';
import '../../../constant/dummy_data.dart';
import '../../../constant/text_size.dart';

class IncomeInformationScreen extends StatelessWidget {
  const IncomeInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Text(
          'Income Information',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: GridView.builder(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: DummyData.incomeInfoDataList.length,
          itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NormalCard(
                    onTap: () {
                      switch (index) {
                        case 0:
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  const IncomeCategoryWidget());
                        case 1:
                          Navigator.pushNamed(
                              context, AppRouter.rentalIncomeScreen);
                          break;
                        case 2:
                          Navigator.pushNamed(
                              context, AppRouter.agricultureIncomeScreen);
                          break;
                        case 3:
                          Navigator.pushNamed(
                              context, AppRouter.businessIncomeScreen);
                          break;
                        case 4:
                          Navigator.pushNamed(
                              context, AppRouter.financialAssetIncomeScreen);
                          break;
                        case 5:
                          Navigator.pushNamed(
                              context, AppRouter.othersIncomeScreen);
                          break;
                        case 6:
                          Navigator.pushNamed(
                              context, AppRouter.capitalGainIncomeScreen);
                          break;
                        case 7:
                          Navigator.pushNamed(context,
                              AppRouter.partnershipBusinessIncomeScreen);
                          break;
                        case 8:
                          Navigator.pushNamed(
                              context, AppRouter.foreignIncomeScreen);
                          break;
                        case 9:
                          Navigator.pushNamed(
                              context, AppRouter.spouseChildrenIncomeScreen);
                          break;
                      }
                    },
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      DummyData.incomeInfoDataList[index].iconAsset,
                      height: size.width * .12,
                      width: size.width * .12,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      DummyData.incomeInfoDataList[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: TextSize.homeCardTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
    );
  }
}
