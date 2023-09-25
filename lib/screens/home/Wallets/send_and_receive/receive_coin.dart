import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/BalanceController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';
class ReceiveCoin extends StatelessWidget {

  SupportedCoin coin;
  ReceiveCoin({required this.coin});

  late WalletController wc;
  late TransactionController tc;

  @override
  Widget build(BuildContext context) {
    wc=Provider.of<WalletController>(context,listen: false);
    tc=Provider.of<TransactionController>(context,listen: false);
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: themeController.isDark?Colors.white:Colors.black,
              ),

            ),
            title: SmallText(
                text: "Receive ${coin.asset_name}",
                color: w_text_color,
                weight: FontWeight.bold,
                align: TextAlign.start
            ),
            actions: [
              Image.asset(
                coin.coinImage,
                fit: BoxFit.cover,
                errorBuilder: (context,v,_)=>Icon(
                  Icons.error,
                  size: getsmallIconSize(),
                ),
              )
            ],
          ),
          body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(8.sp),
            child: Consumer<BalanceController>(
                builder: (context,bc,child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width*0.6,
                        height: height*0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.sp))
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child: Center(
                          child: PrettyQr(
                            image: const AssetImage('assets/logo.png'),
                            size: 150.sp,
                            data: coin.wallet_address!,
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                        )
                      ),
                      SizedBox(height: height*0.01,),
                      SizedBox(
                        width: width*0.7,
                        child: SmallText(
                          text: coin.wallet_address!,
                          color: w60_text_color,
                          weight: FontWeight.normal,
                          align: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: height*0.05,),
                      SizedBox(
                        width: width*0.7,
                        child: SmallText(
                          text: "Send only ${coin.asset_name} to this address. Sending any other coins may result in permanent loss",
                          color: w60_text_color,
                          weight: FontWeight.w300,
                          align: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: 10.sp,),
                      SizedBox(
                        width: width*0.7,
                        child: SmallText(
                          text: "Note: 10 XRP is needed to activate this wallet. 10 XRP will be deducted from the first transaction received on this address",
                          color: w60_text_color,
                          weight: FontWeight.normal,
                          align: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      IconButton(
                          onPressed: (){
                            FlutterClipboard.copy(coin.wallet_address!).then((value) => log(coin.wallet_address!));
                            ShowSnackBar.show(context, "Copied!",Colors.greenAccent);
                          },
                          icon: Icon(
                            Icons.copy,
                            color: themeController.isDark?Colors.white:Colors.grey,
                            size: 30.sp,
                          )
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
