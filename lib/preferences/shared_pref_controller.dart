import 'package:shared_preferences/shared_preferences.dart';
enum PrefKeys{
  loggedIn
}
class SharedPrefController{
  SharedPrefController._();
  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;
  factory SharedPrefController(){
    return _instance ??=SharedPrefController._();
  }
  Future<void>initPref()async{
    _sharedPreferences=await SharedPreferences.getInstance();
  }
  Future<void> save()async{
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
  }
bool get loggedIn=>_sharedPreferences.getBool(PrefKeys.loggedIn.name) ?? false ;

  Future<bool> removeValue({required String key})async{
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.remove(key);
    }
    return false;
  }
   Future<bool> clear()async{
     return _sharedPreferences.clear();
   }
}