import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/button/MyButton.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/component/texts/constants.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/new_wallet/controller/import_wallet_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';
import 'controller/new_wallet_controller.dart';


class ImportWallet extends StatefulWidget {
  @override
  State<ImportWallet> createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  final _formKey=GlobalKey<FormState>();
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: themeController.isDark?Colors.white:Colors.black54,
                size: getBigIconSize(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            centerTitle: false,
            title: const Text(
                "Import"
            ),
          ),
          body: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(12.sp),
            child: SingleChildScrollView(
              child: Consumer<NewWalletController>(
                  builder: (context,newWalletController,child) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.05,),
                          TextFormField(
                            style: TextStyle(
                                color: w60_text_color
                            ),
                            minLines: 6,
                            maxLines: 7,
                            cursorColor: Colors.black54,
                            validator: (val)=>val!.isEmpty?"Invalid mnemonic":null,
                            initialValue: newWalletController.passphrase,
                            decoration: textfieldDecoration.copyWith(hintText: "Mnemonic",hintStyle: TextStyle(color: w60_text_color),fillColor: Colors.white10),
                            onChanged: (val){
                              newWalletController.mnemonic=val;
                            },
                          ),
                          SizedBox(height: height*0.02),
                          SmallText(
                            text: passphrase_desc,
                            color: w10_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.start,
                            maxLines: 15,
                          ),
                          SizedBox(height: height*0.02,),
                          ListTile(
                            tileColor: themeController.isDark?primary_color_light:Colors.grey[300],
                            contentPadding: EdgeInsets.all(10.sp),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.sp))
                            ),
                            leading: const SizedBox(),
                            title: MediumText(
                                text: "Passphrase",
                                color: Colors.white70,
                                weight: FontWeight.normal,
                                align: TextAlign.start
                            ),
                            trailing: GestureDetector(
                              onTap: (){

                              },
                              child: SizedBox(
                                width: width*0.25,
                                child: CupertinoSwitch(
                                    activeColor: Colors.green,
                                    value: newWalletController.isPassPhrase,
                                    onChanged: (val){
                                      newWalletController.changePassPhrase(val);
                                    }
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.02,),
                          newWalletController.isPassPhrase?Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    color: themeController.isDark?Colors.white60:Colors.black54
                                ),
                                cursorColor: themeController.isDark?Colors.white10:lb_text_color,
                                validator: (val)=>val!.isEmpty?"Invalid passphrase":null,
                                initialValue: newWalletController.passphrase,
                                decoration: textfieldDecoration.copyWith(hintText: "Passphrase",hintStyle:TextStyle(color: themeController.isDark?w60_text_color:lb_text_color),fillColor: themeController.isDark?primary_color_light:Colors.grey[300]),
                                onChanged: (val){
                                  newWalletController.passphrase=val;
                                },
                              ),
                              SizedBox(height: height*0.02,),
                              TextFormField(
                                style: TextStyle(
                                    color: themeController.isDark?Colors.white60:Colors.black54
                                ),
                                cursorColor: Colors.white10,
                                validator: (val)=>val!.isEmpty&&val.toString()!=newWalletController.passphrase?"passphrase does not match":null,
                                decoration: textfieldDecoration.copyWith(hintText: "Confirm",hintStyle:TextStyle(color: themeController.isDark?w60_text_color:lb_text_color),fillColor: themeController.isDark?primary_color_light:Colors.grey[300]),
                                onChanged: (val){

                                },
                              ),

                            ],
                          ):const SizedBox(),
                          SizedBox(height: 20.sp,),
                          _isLoading?const Loading():MyButton(
                            text: "Restore",
                            bgColor: button_color,
                            txtColor: w_text_color,
                            bgRadius: 4.sp,
                            verticalPadding: 15.sp,
                            width: width,
                            onPressed: ()async{
                              if(_formKey.currentState!.validate()){
                                try{
                                  _isLoading=true;
                                  setState(() {

                                  });
                                  var ctl=Provider.of<NewWalletController>(context,listen: false);
                                  await Provider.of<ImportWalletController>(context,listen: false).importFromMnemonics(ctl.mnemonic!.trim().toString(),context);
                                  _isLoading=true;
                                  setState(() {

                                  });
                                  Navigator.pushNamedAndRemoveUntil(context, AppRoute.homepage, (route) => false);
                                }catch(e){
                                  log(e.toString());
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        );
      }
    );
  }
}
