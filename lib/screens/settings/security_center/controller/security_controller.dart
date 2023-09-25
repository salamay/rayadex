import 'package:flutter/cupertino.dart';

class SecurityController extends ChangeNotifier{
  bool isPassCode=false;

  void changePassCodeStatus(bool status){
    isPassCode=status;
    notifyListeners();
  }
}