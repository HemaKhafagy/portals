import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static late SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveDataFromSharedPref({required String key,required dynamic value}) async
  {
    if(value is double) return await sharedPreferences.setDouble(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setString(key, value);
  }

  static dynamic getDataFromSharedPref({required String key})
  {
    return sharedPreferences.get(key);
  }

  static Future<bool> clearDataFromSharedPref({required String key})async
  {
    return await sharedPreferences.remove(key);
  }




}