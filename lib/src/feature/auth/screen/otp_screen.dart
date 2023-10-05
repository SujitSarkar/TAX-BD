import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tax_bd/src/shared/widget/loading_widget.dart';
import '../../../constant/app_color.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/normal_card.dart';
import '../../../shared/widget/solid_button.dart';
import '../../../shared/widget/text_field_widget.dart';
import '../provider/auth_provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.appbarBgColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: authProvider.otpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .1),
              NormalCard(
                  padding: const EdgeInsets.all(12),
                  borderRadius: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('We have sent a code to',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.bodyText)),
                          Text('+88${authProvider.phoneController.text}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: TextSize.bodyText))
                        ],
                      ),
                      const Icon(Icons.phone_android,
                          size: 30, color: Colors.white)
                    ],
                  )),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                controller: authProvider.otpController,
                textInputType: TextInputType.number,
                required: true,
                labelText: 'Verification code',
                hintText: 'Type 6-digit verification code',
              ),
              const SizedBox(height: 40),
              SolidButton(
                  onTap: () async {
                    await authProvider.verifyOtpButtonOnTap();
                  },
                  child: authProvider.loading
                      ? const LoadingWidget()
                      : const Text(
                          'Verify OTP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: TextSize.bodyText,
                              fontWeight: FontWeight.bold),
                        )),
              const SizedBox(height: 10),
              authProvider.seconds > 0
                  ? Text('Time remaining ${authProvider.seconds} sec',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: TextSize.bodyText))
                  : RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: TextSize.bodyText),
                        children: [
                          const TextSpan(text: 'Having trouble? '),
                          TextSpan(
                            text: 'Resend code',
                            style: const TextStyle(
                                color: AppColor.secondaryColor,
                                fontSize: TextSize.bodyText),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (authProvider.seconds <= 0) {
                                  await authProvider.verifyPhoneViaOTP();
                                }
                              },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
