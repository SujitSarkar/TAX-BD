import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../../../constant/text_size.dart';
import '../../../shared/widget/loading_widget.dart';
import '../../../shared/widget/solid_button.dart';
import '../../../shared/widget/text_field_widget.dart';
import '../provider/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
          key: authProvider.signInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/logo_trans.png',
                        height: 80, width: 80),
                    const SizedBox(height: 10),
                    const Text(
                      'Income TAX BD',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: TextSize.titleText),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * .1),
              TextFormFieldWidget(
                controller: authProvider.phoneController,
                labelText: 'Phone number',
                hintText: 'Enter your phone number',
                required: true,
                maxLength: 11,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              SolidButton(
                  onTap: () async {
                    await authProvider.signInButtonOnTap();
                  },
                  child: authProvider.loading
                      ? const LoadingWidget(color: Colors.white)
                      : const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: TextSize.bodyText,
                              fontWeight: FontWeight.bold),
                        )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 60,
        child: Column(children: [
          Text(
            'More Information',
            style: TextStyle(fontSize: TextSize.bodyText),
          ),
          SizedBox(height: 5),
          SelectableText(
            '01777777777',
            style: TextStyle(fontSize: TextSize.bodyText),
          ),
        ]),
      ),
    );
  }
}
