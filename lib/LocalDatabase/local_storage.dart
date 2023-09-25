import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  Future<void> setPassCode(String passcode)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("passcode", passcode);
  }
  Future<String?> getPassCode()async{
    final prefs = await SharedPreferences.getInstance();
    String? value= prefs.getString("passcode");
    return value;
  }

  Future<void> togglePasscodeStatus(bool status)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("passcode_status", status);
  }
  Future<bool?> passCodeStatus()async{
    final prefs = await SharedPreferences.getInstance();
    bool? value= prefs.getBool("passcode_status");
    return value;
  }
}