import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tax_bd/src/router/app_router.dart';
import '../../constant/text_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    onInit();
    super.initState();
  }

  Future<void> onInit() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await Future.delayed(const Duration(seconds: 1)).then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.home, (route) => false));
    } else {
      await Future.delayed(const Duration(seconds: 2)).then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.signIn, (route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/image/bd_logo.png', height: 80, width: 80),
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
    ));
  }
}
