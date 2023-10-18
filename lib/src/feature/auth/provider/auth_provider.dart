import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tax_bd/src/constant/local_storage_key.dart';
import 'package:tax_bd/src/router/app_router.dart';
import 'package:tax_bd/src/shared/app_navigator_key.dart';
import 'package:tax_bd/src/shared/local_storage.dart';
import '../../../constant/app_toast.dart';
import '../../../shared/validator.dart';
import '../../home/screen/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final GlobalKey<FormState> otpFormKey = GlobalKey();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? _verificationId;
  Timer? _timer;
  int seconds = 120;

  void disposeAll() {
    loading = false;
    phoneController.clear();
    otpController.clear();
    _timer?.cancel();
  }

  ///Funstions::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> storeDataToLocal(User user) async {
    await setData(LocalStorageKey.phoneKey, phoneController.text);
    await setData(LocalStorageKey.userIdKey, user.uid);
    debugPrint('Phone: ${phoneController.text}');
    debugPrint('Uid: ${user.uid}');

    phoneController.clear();
    otpController.clear();
  }

  Future<void> signInButtonOnTap() async {
    if (!signInFormKey.currentState!.validate()) {
      return;
    }
    if (phoneValidator(phoneController.text) == false) {
      showToast('Invalid phone number');
      return;
    }
    await verifyPhoneViaOTP();
  }

  Future<void> verifyPhoneViaOTP() async {
    try {
      _timer?.cancel();
      loading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: '+88${phoneController.text}',

        ///Auto Verification
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {
            final User? user = value.user;
            if (user != null) {
              await storeDataToLocal(user).then((value) async{
                _timer?.cancel();
                loading = false;
                notifyListeners();
                await const HomeScreen().onInit().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        AppNavigatorKey.key.currentState!.context, AppRouter.home, (route) => false));
              });
            } else {
              loading = false;
              notifyListeners();
              showToast('Verification Failed! Try again');
            }
          });
        },

        ///Verification Failed
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            loading = false;
            notifyListeners();
            showToast('The provided phone number is not valid');
          }
          loading = false;
          notifyListeners();
          showToast('Something went wrong');
        },

        ///Verify with  OTP
        codeSent: (String? verificationId, int? resendToken) async {
          _verificationId = verificationId;
          _startTimer();
          loading = false;
          notifyListeners();
          Navigator.pushNamed(
              AppNavigatorKey.key.currentState!.context, AppRouter.otpScreen);
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // showToast('OTP resend');
          _verificationId = verificationId;
          _timer?.cancel();
          _startTimer();
        },
      );
    } on SocketException {
      loading = false;
      notifyListeners();
      showToast('No internet connection');
    } catch (error) {
      loading = false;
      notifyListeners();
      showToast(error.toString());
    }
  }

  Future<void> verifyOtpButtonOnTap() async {
    if (!otpFormKey.currentState!.validate()) {
      return;
    }
    if (otpValidator(otpController.text) == false) {
      showToast('OTP must be 6 digit');
      return;
    }
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otpController.text);
      loading = true;
      notifyListeners();
      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        final User? user = value.user;
        if (user != null) {
          await storeDataToLocal(user).then((value) async{
            _timer?.cancel();
            loading = false;
            notifyListeners();
            await const HomeScreen().onInit().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    AppNavigatorKey.key.currentState!.context, AppRouter.home, (route) => false));
          });
        } else {
          loading = false;
          notifyListeners();
          showToast('Invalid OTP');
        }
      });
    } catch (e) {
      loading = false;
      notifyListeners();
      showToast('Failed!');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (seconds == 0) {
          timer.cancel();
        } else {
          seconds--;
          notifyListeners();
        }
      },
    );
  }
}
