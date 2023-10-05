import 'package:get_storage/get_storage.dart';

///Get Storage Functions
Future<void> setData(String key, dynamic value) async =>
    await GetStorage().write(key, value);
int? getInt(String key) => GetStorage().read(key);
String? getString(String key) => GetStorage().read(key);
bool? getBool(String key) => GetStorage().read(key);
double? getDouble(String key) => GetStorage().read(key);
dynamic getData(String key) => GetStorage().read(key);
Future<void> clearLocalData() async => await GetStorage().erase();
