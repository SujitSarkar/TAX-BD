import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import '../../constant/app_toast.dart';
import '../../constant/local_storage_key.dart';
import '../../feature/auth/repository/auth_repository.dart';
import '../local_storage.dart';

class FirebaseDbHelper {
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<bool> insertData(
      {required String childPath, required Map<String, dynamic> data}) async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final String? userId = await getData(LocalStorageKey.userIdKey);

    bool result = false;
    if (userPhone == null || userId == null) {
      await AuthRepository().logout();
      showToast('Invalid credential! Login again');
      return result;
    }

    try {
      await _dbRef.child(userPhone).child(childPath).set(data).then((_) {
        result = true;
      }).catchError((error) {
        debugPrint('Error inserting $childPath data::::::: $error');
        result = false;
      });
    } catch (error) {
      debugPrint('Error inserting $childPath data::::::: $error');
      result = false;
    }
    return result;
  }

  Future<bool> updateData(
      {required String childPath, required Map<String, dynamic> data}) async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final String? userId = await getData(LocalStorageKey.userIdKey);

    bool result = false;
    if (userPhone == null || userId == null) {
      await AuthRepository().logout();
      showToast('Invalid credential! Login again');
      return result;
    }

    try {
      await _dbRef.child(userPhone).child(childPath).update(data).then((_) {
        result = true;
      }).catchError((error) {
        debugPrint('Error updating $childPath data::::::: $error');
        result = false;
      });
    } catch (error) {
      debugPrint('Error updating $childPath data::::::: $error');
      result = false;
    }
    return result;
  }

  Future<Map<String, dynamic>?> fetchData({required String childPath}) async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final String? userId = await getData(LocalStorageKey.userIdKey);

    if (userPhone == null || userId == null) {
      await AuthRepository().logout();
      showToast('Invalid credential! Login again');
      return null;
    }

    try {
      DataSnapshot dataSnapshot = await _dbRef.child(userPhone).child(childPath).get();
      if (dataSnapshot.value != null) {
        final Object? data = dataSnapshot.value;
        final String jsonString = jsonEncode(data);
        final Map<String, dynamic> mapData = jsonDecode(jsonString);
        debugPrint('Retrieved $childPath data: $data');
        return mapData;
      } else {
        debugPrint('No $childPath data not found');
      }
    } catch (error) {
      debugPrint('Error fetching $childPath data:::::: $error');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> fetchListData({required String childPath}) async {
    final String? userPhone = await getData(LocalStorageKey.phoneKey);
    final String? userId = await getData(LocalStorageKey.userIdKey);

    if (userPhone == null || userId == null) {
      await AuthRepository().logout();
      showToast('Invalid credential! Login again');
      return null;
    }

    try {
      DataSnapshot dataSnapshot = await _dbRef.child(userPhone).child(childPath).child('data').get();
      if (dataSnapshot.value != null) {
        final Object? data = dataSnapshot.value;
        final String jsonString = jsonEncode(data);
        final List<Map<String, dynamic>>? listData = jsonDecode(jsonString);
        debugPrint('Retrieved $childPath data: $data');
        return listData;
      } else {
        debugPrint('$childPath data not found');
      }
    } catch (error) {
      debugPrint('Error fetching $childPath data:::::: $error');
    }
    return null;
  }
}
