import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tax_bd/src/constant/dummy_data.dart';
import 'package:tax_bd/src/constant/text_size.dart';
import 'package:tax_bd/src/feature/auth/repository/auth_repository.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/shared/widget/normal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthRepository().logout();
              },
              splashRadius: 24,
              icon: const Icon(LineAwesomeIcons.alternate_sign_out))
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/image/bd_logo.png', height: 60, width: 60),
                const SizedBox(width: 12),
                const Text(
                  'Income TAX BD',
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
                                case 5:
                                  Navigator.pushNamed(
                                      context, AppRouter.costInformationScreen);
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
