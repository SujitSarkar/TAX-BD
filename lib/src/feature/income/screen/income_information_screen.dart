import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/income/widget/income_category_widget.dart';
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
          'আয়ের তথ্য',
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
                        }
                      },
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        DummyData.incomeInfoDataList[index].icon,
                        size: size.width * .15,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      DummyData.incomeInfoDataList[index].title!,
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
