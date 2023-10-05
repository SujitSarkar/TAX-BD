import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../../constant/app_toast.dart';
import '../../../constant/local_storage_key.dart';
import '../../../shared/app_navigator_key.dart';
import '../../../router/app_router.dart';
import '../../../shared/local_storage.dart';

class AuthRepository {
  Future<bool> signin() async {
    bool result = false;

    return result;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await clearLocalData().then((value) {
        Navigator.pushNamedAndRemoveUntil(
            AppNavigatorKey.key.currentState!.context,
            AppRouter.signIn,
            (route) => false);
      });
    } catch (e) {
      debugPrint(e.toString());
      showToast('Logout failed');
    }
  }
}
