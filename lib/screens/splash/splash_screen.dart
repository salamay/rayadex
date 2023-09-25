import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_storage.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/settings/security_center/controller/security_controller.dart';
import 'dart:async';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import '../../LocalDatabase/local_db.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late WalletController wc;
  final LocalStorage _localStorage=LocalStorage();
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wc=Provider.of<WalletController>(context,listen: false);
    initialize();
  }

  void initialize()async{
    log("Initializing Database");
    LocalDatabase localDatabase=LocalDatabase();
    String path=await localDatabase.getDbPath();
    await localDatabase.initDB(path);
    await biometricCheck();
    // _walletConnectController.connect();
  }

  Future<void> biometricCheck()async{
    bool? fStatus=await _localStorage.passCodeStatus();
    if(fStatus!=null){
      Provider.of<SecurityController>(context,listen: false).changePassCodeStatus(fStatus);
      if(fStatus){
        Navigator.push(
            context,
            PageRouteBuilder(
              opaque: true,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  Consumer<ThemeController>(
                    builder: (context,themeController,_) {
                      return PasscodeScreen(
                        title: SmallText(
                            text: "Enter passcode",
                            color: themeController.isDark?w_text_color:lb_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.center
                        ),
                        passwordEnteredCallback: (val)async{
                          log(val);
                          String? passCode=await _localStorage.getPassCode();
                          bool isValid = passCode == val;
                          _verificationNotifier.add(isValid);
                          goToHome(context);
                        },
                        cancelButton: SmallText(
                            text: "Cancel",
                            color: themeController.isDark?w_text_color:lb_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.center
                        ),
                        deleteButton: SmallText(
                            text: "Delete",
                            color: themeController.isDark?w_text_color:lb_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.center
                        ),
                        shouldTriggerVerification: _verificationNotifier.stream,
                      );
                    }
                  ),
            ));
      }else{
        goToHome(context);
      }
    }else{
      goToHome(context);
    }
  }

  void goToHome(context){
    Future.delayed( const Duration(seconds: 3,),()async{
      final wallets=await wc.getAllUserWallet(context);
      if(wallets!=null){
        if(wallets.isNotEmpty){
          Navigator.pushNamedAndRemoveUntil(context, AppRoute.homepage, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, AppRoute.walletAction, (route) => false);
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(context, AppRoute.walletAction, (route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          body: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png",fit: BoxFit.contain,width: width*0.3,height: height*0.15,),
              ],
            ),
          ),
        );
      }
    );
  }
}
