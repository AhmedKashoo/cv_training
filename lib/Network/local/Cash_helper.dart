import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences ?sharedPreferences;
static init()async{
  sharedPreferences=await SharedPreferences.getInstance();
}
static Future<void> putdata({
  required String key,
  required bool value
})async{
 await sharedPreferences?.setBool(key, value);
}
  static bool? getdata({
    required String key,
  }){
    return sharedPreferences?.getBool(key);
  }
  static Future<void> savedata({required String key,required dynamic value})async{
  if(value is String) await sharedPreferences!.setString(key, value);
  if(value is bool) await sharedPreferences!.setBool(key, value);
  if(value is int) await sharedPreferences!.setInt(key, value);
  if(value is double) await sharedPreferences!.setDouble(key, value);



  }
  static dynamic get({
    required String key,
  }){
    return sharedPreferences?.get(key);
  }
  static Future<bool> removeData({ required String key,})async{
    return await sharedPreferences!.remove(key);
  }
}