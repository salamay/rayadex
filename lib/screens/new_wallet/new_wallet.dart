import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';

import '../../component/button/MyButton.dart';
import '../../component/texts/constants.dart';
import 'controller/new_wallet_controller.dart';
class NewWallet extends StatefulWidget {


  NewWallet({Key? key}) : super(key: key);

  @override
  State<NewWallet> createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  final _formKey=GlobalKey<FormState>();
  List<String> mnemonicType=[
    "12 Words",
    "24 Words"
  ];

  int mnemonicStrength=128;
  NewWalletController? newWalletController;
  String? selectedType="12 Words";
  bool _isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newWalletController=Provider.of<NewWalletController>(context,listen: false);
  }
  Future<void> createWallet({String? passphrase})async{
    try{
      if(selectedType=="12 Words"){
        mnemonicStrength=128;
      }else{
        mnemonicStrength=256;
      }
      await newWalletController!.createWallet(passphrase: passphrase,context: context,strength: mnemonicStrength);
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.homepage, (route) => false);
    }catch(e){
      log(e.toString());
    }
  }
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
              "New wallet"
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(12.sp),
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Consumer<NewWalletController>(
                builder: (context,newWalletController,child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _mnemonicSelector(context,themeController),
                      SizedBox(height: height*0.04),
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
                      SizedBox(height: height*0.05,),
                      newWalletController.isPassPhrase?Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors.white60
                                ),
                                cursorColor: Colors.white10,
                                validator: (val)=>val!.isEmpty?"Invalid passphrase":null,
                                initialValue: newWalletController.passphrase,
                                decoration: textfieldDecoration.copyWith(hintText: "Passphrase",hintStyle:TextStyle(color: themeController.isDark?w60_text_color:lb_text_color),fillColor: themeController.isDark?primary_color_light:Colors.grey[300]),
                                onChanged: (val){
                                  newWalletController.passphrase=val;
                                },
                              ),
                              SizedBox(height: height*0.02,),
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors.white60
                                ),
                                cursorColor: Colors.white10,
                                validator: (val)=>val!.isEmpty&&val.toString()!=newWalletController.passphrase?"passphrase does not match":null,
                                decoration: textfieldDecoration.copyWith(hintText: "Confirm",hintStyle:TextStyle(color: themeController.isDark?w60_text_color:lb_text_color),fillColor: themeController.isDark?primary_color_light:Colors.grey[300]),
                                onChanged: (val){

                                },
                              ),
                              SizedBox(height: height*0.02),
                              SmallText(
                                text: passphrase_desc,
                                color: w10_text_color,
                                weight: FontWeight.normal,
                                align: TextAlign.start,
                                maxLines: 15,
                              )
                            ],
                          )
                      ):const SizedBox(),
                      _isLoading?const Loading():MyButton(
                        text: "Create",
                        bgColor: button_color,
                        txtColor: w_text_color,
                        bgRadius: 4.sp,
                        verticalPadding: 15.sp,
                        width: width,
                        onPressed: ()async{
                          if(Provider.of<NewWalletController>(context,listen: false).isPassPhrase){
                            if(_formKey.currentState!.validate()){
                              _isLoading=true;
                              setState(() {

                              });
                              await createWallet(passphrase: Provider.of<NewWalletController>(context,listen: false).passphrase);
                              _isLoading=false;
                              setState(() {

                              });
                            }
                          }else{
                            _isLoading=true;
                            setState(() {

                            });
                            await createWallet();
                            _isLoading=false;
                            setState(() {

                            });
                          }
                        },
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _mnemonicSelector(context,themeController){
    return PopupMenuButton<int>(
      onSelected: (selected) {
        switch (selected) {
          case 0:
            print(selected);
            selectedType=mnemonicType[0];
            setState(() {

            });
            break;
          case 1:
            print(selected);
            selectedType=mnemonicType[1];
            setState(() {

            });
            break;
        }
      },
      child: ListTile(
        tileColor: themeController.isDark?primary_color_light:Colors.grey[300],
        contentPadding: EdgeInsets.all(10.sp),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.sp))
        ),
        leading: const SizedBox(),
        title: MediumText(
            text: "Mnemonics",
            color: Colors.white70,
            weight: FontWeight.normal,
            align: TextAlign.start
        ),
        trailing: SizedBox(
          width: width*0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallText(
                  text: selectedType!,
                  color: w10_text_color,
                  weight: FontWeight.normal,
                  align: TextAlign.start
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: w_text_color,
                size: getsmallIconSize(),
              )
            ],
          ),
        ),

      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: SizedBox(
              width: width,
              child: SmallText(
                  text: mnemonicType[0],
                  color: Colors.white70,
                  weight: FontWeight.normal,
                  align: TextAlign.start
              ),
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: SizedBox(
              width: width,
              child: SmallText(
                  text: mnemonicType[1],
                  color: Colors.white70,
                  weight: FontWeight.normal,
                  align: TextAlign.start
              ),
            ),
          ),
        ];
      },
      color: primary_color_light,
    );
  }
}
