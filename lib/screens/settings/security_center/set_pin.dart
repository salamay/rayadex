import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_storage.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/button/MyButton.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/security_center/controller/security_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class SetPin extends StatelessWidget {
  final TextEditingController pinController=TextEditingController();
  final TextEditingController confirmPinController=TextEditingController();
  final LocalStorage _localStorage=LocalStorage();
  @override
  Widget build(BuildContext context) {
    final _key=GlobalKey<FormState>();
    return Consumer<ThemeController>(
        builder: (context,themeController,_) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                  "Set Pin",
              ),
            ),
            body: Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(8.sp),
              child: Consumer<SecurityController>(
                  builder: (context,sc,child) {
                    return Form(
                      key: _key,
                      onChanged: (){
                        log("Form changed");
                        if(_key.currentState!.validate()){

                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 15.sp,),
                          TextFormField(
                            cursorColor: themeController.isDark?Colors.amber:Colors.black54,
                            keyboardType: TextInputType.number,
                            controller: pinController,
                            decoration: textfieldDecoration.copyWith(fillColor: themeController.isDark?primary_color_light:Colors.grey[300],hintText: " 123456",hintStyle: TextStyle(color:lb_text_color)),
                            validator: (val)=>val!.length!=6?"Passcode should be 6 digit":null,
                            style: GoogleFonts.lato(
                                color: themeController.isDark?Colors.white60:Colors.black54,
                                fontSize: smallFont()
                            ),
                          ),
                          SizedBox(height: 20.sp,),
                          SizedBox(
                            child: TextFormField(
                              controller: confirmPinController,
                              keyboardType: TextInputType.number,
                              cursorColor: themeController.isDark?Colors.amber:Colors.black54,
                              decoration: textfieldDecoration.copyWith(fillColor: themeController.isDark?primary_color_light:Colors.grey[300],hintText: "Confirm passcode",hintStyle: TextStyle(color: lb_text_color)),
                              validator: (val)=>val.toString()!=pinController.text?"Passcode does not match":null,
                              style: GoogleFonts.lato(
                                  color: themeController.isDark?Colors.white60:Colors.black54,
                                  fontSize: smallFont()
                              ),
                            ),
                          ),
                          SizedBox(height: 25.sp,),
                          MyButton(
                              text: "Save",
                              verticalPadding: 15.sp,
                              bgColor: primary_color_button,
                              txtColor: lb_text_color,
                              bgRadius: 20.sp,
                              width: width,
                              onPressed: ()async{
                                if(_key.currentState!.validate()){
                                  try{
                                    await _localStorage.setPassCode(pinController.text);
                                    await _localStorage.togglePasscodeStatus(true);
                                    Provider.of<SecurityController>(context,listen: false).changePassCodeStatus(true);
                                    Navigator.pop(context);
                                  }catch(e){
                                    log(e.toString());
                                  }
                                }
                              }
                          ),

                        ],
                      ),
                    );
                  }
              ),
            ),
          );
        }
    );
  }
}
