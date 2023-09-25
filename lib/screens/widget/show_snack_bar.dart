import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ryipay/component/snackbar/error_snackbar.dart';

class ShowSnackBar{

  static void show(BuildContext context,String message,Color color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ErrorSnackbar(
        text: message,),
      backgroundColor: color,));
  }
}