import 'package:flutter/material.dart';
import 'package:tax_bd/src/shared/widget/normal_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/text_size.dart';
import '../../../shared/validator.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        titleSpacing: 0.0,
        title: const Text(
          'About Us',
          style: TextStyle(
              fontSize: TextSize.titleText, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(children: [
          const NormalCard(
              padding:  EdgeInsets.all(12),
              bgColor: Colors.white,
              child:  Text(
                  'We are a Blockchain and AI research and development company with 41 Researchers, Engineers, Designers, and Developers across USA and Bangladesh',
              style: TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),

          const NormalCard(
              padding: EdgeInsets.all(12),
              bgColor: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'What we believe in',
                      style: TextStyle(fontSize: TextSize.titleText)),
                  SizedBox(height: 12),
                  Text(
                      'Our vision is to frontier the seamless integration of blockchain and AI, empowering individuals and industries worldwide by delivering innovative solutions that revolutionize efficiency, trust, and access.',
                      style: TextStyle(fontSize: TextSize.bodyText)),
                  SizedBox(height: 20),

                  Text(
                      'Why we do what we do',
                      style: TextStyle(fontSize: TextSize.titleText)),
                  SizedBox(height: 12),
                  Text(
                    'Our mission is to collaborate with visionary leaders, governments, and impactful initiatives, we strive to create a more efficient, and accessible future. We empower millions of individuals, industries.',
                      style: TextStyle(fontSize: TextSize.bodyText)),
                  SizedBox(height: 12),
                ],
              )),
          const SizedBox(height: 12),

          NormalCard(
              padding: const EdgeInsets.all(12),
              bgColor: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'Business',
                      style: TextStyle(fontSize: TextSize.titleText)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: ()async{
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'info@anchorblock.vc',
                        query: encodeQueryParameters(<String, String>{
                          'subject': 'Write a subject here',
                        }),
                      );
                      await launchUrl(emailLaunchUri);
                    },
                    child: const Text(
                      'info@anchorblock.vc',
                        style: TextStyle(fontSize: TextSize.bodyText,color: Colors.blue)),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                      'Our Offices',
                      style: TextStyle(fontSize: TextSize.titleText)),
                  const SizedBox(height: 8),
                  const Text(
                      'Miami, USA 🇺🇸\nDhaka, BD 🇧🇩',
                      style: TextStyle(fontSize: TextSize.bodyText)),
                  const SizedBox(height: 12),

                  const Text(
                      'Contact',
                      style: TextStyle(fontSize: TextSize.titleText)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: ()async{
                      await launchPhone("+8801740230313");
                    },
                    child: const Text(
                        '+880 1740-230313',
                        style: TextStyle(fontSize: TextSize.bodyText,color: Colors.blue)),
                  ),
                  const SizedBox(height: 12),
                ],
              )),
        ]),
      ),
    );
  }
}
