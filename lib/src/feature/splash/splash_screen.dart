import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tax_bd/src/feature/home/screen/home_screen.dart';
import 'package:tax_bd/src/router/app_router.dart';

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
      await const HomeScreen().onInit().then((value) =>
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        // child: SvgPicture.asset('assets/icon/personal_info.svg',colorFilter:const ColorFilter.mode(Colors.red, BlendMode.srcIn),),
        child: Hero(
            tag: 'splashToLogin',
            child: Image.asset('assets/image/logo_trans.png')),
      ),
    ));
  }
}
