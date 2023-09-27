import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';
class BackupPhrase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
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
            title: MediumText(
                text: "Backup",
                color: w_text_color,
                weight: FontWeight.bold,
                align: TextAlign.start
            ),
          ),
          body: Consumer<WalletController>(
              builder: (context,wc,_) {
                var wallet=wc.currentWallet;
              return Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        color: themeController.isDark?primary_color_light:Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))
                      ),
                      child: MediumText(text: wallet!.walletType==WalletType.MULTI.name?wallet.mnemonic!:wallet.privateKey!, color: w60_text_color, weight: FontWeight.bold, align: TextAlign.center,maxLines: 10,),
                    ),
                    SizedBox(height: 20.sp,),
                    SizedBox(
                      width: width*0.7,
                      child: SmallText(
                        text: wc.currentWallet!.walletType==WalletType.MULTI?"Make sure you write down your secret phrase so as to prevent asset loss. Thanks":"Make sure you copy your private key so as to prevent asset loss. Thanks",
                        color: w60_text_color,
                        weight: FontWeight.normal,
                        align: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                    IconButton(
                        onPressed: (){
                          try {
                            String data=wallet.walletType==WalletType.MULTI.name?wallet.mnemonic!:wallet.privateKey!;
                            FlutterClipboard.copy(data).then((value) => log(data));
                            ShowSnackBar.show(context, "Copied!",Colors.greenAccent);
                          }catch(e){
                            log(e.toString());
                          }

                        },
                        icon: Icon(
                          Icons.copy,
                          color: themeController.isDark?Colors.white:Colors.black54,
                          size: 30.sp,
                        )
                    )
                  ],
                )
              );
            }
          ),
        );
      }
    );
  }
}
