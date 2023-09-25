import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ThemeController extends ChangeNotifier{
  bool isDark=true;

  void changeTheme(bool value){
    isDark=value;
    log("Theme: isDark $value");
    notifyListeners();
  }
}