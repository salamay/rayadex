import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_storage.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/settings/security_center/controller/security_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class AppSecurity extends StatefulWidget {
  const AppSecurity({Key? key}) : super(key: key);

  @override
  State<AppSecurity> createState() => _AppSecurityState();
}

class _AppSecurityState extends State<AppSecurity> {
  final _localStorage=LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: themeController.isDark?Colors.white:Colors.black,
                size: getBigIconSize(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            centerTitle: false,
            title: Text(
              "Security center",
              style: GoogleFonts.ubuntuMono(
                fontWeight: FontWeight.bold,
                fontSize: mediumFont(),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(8.sp),
            height: height,
            width: width,
            child: Consumer<SecurityController>(
              builder: (context,securityController,_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Passcode",
                          style: GoogleFonts.ubuntuMono(
                            color: themeController.isDark?w60_text_color:lb_text_color,
                            fontWeight: FontWeight.bold,
                            fontSize: mediumFont(),
                          ),
                        ),
                        FlutterSwitch(
                          width: 70.0.sp,
                          height: 40.0.sp,
                          valueFontSize: 10.0.sp,
                          toggleSize: 40.0.sp,
                          value: securityController.isPassCode,
                          borderRadius: 30.0.sp,
                          padding: 5.0.sp,
                          showOnOff: true,
                          inactiveTextColor: Colors.white12,
                          activeColor: Colors.green,
                          onToggle: (val) async{
                            if(val){
                              await Navigator.pushNamed(context, AppRoute.setPin);
                            }else{
                              await _localStorage.togglePasscodeStatus(false);
                              securityController.changePassCodeStatus(false);
                            }
                            log(val.toString());
                          },
                        ),
                      ],
                    )
                  ],
                );
              }
            ),
          ),
        );
      }
    );
  }
}
