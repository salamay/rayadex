import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';
import '../../../../component/button/MyButton.dart';
import '../coins_controller/BalanceController.dart';
import '../model/balance_model/xrp_balance.dart';
class SendCoin extends StatefulWidget {

  SupportedCoin coin;
  SendCoin({required this.coin});

  @override
  State<SendCoin> createState() => _SendCoinState();
}

class _SendCoinState extends State<SendCoin> {
  final _key=GlobalKey<FormState>();
  String walletTo='';
  late WalletController wc;
  late TransactionController tc;
  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );
  final TextEditingController addressController=TextEditingController();
  final TextEditingController amountController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wc=Provider.of<WalletController>(context,listen: false);
    tc=Provider.of<TransactionController>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Loading(),
          child: Scaffold(
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
                  text: "Send ${widget.coin.asset_name}",
                  color: w_text_color,
                  weight: FontWeight.bold,
                  align: TextAlign.start
              ),
              actions: [
                Image.asset(
                  widget.coin.coinImage,
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
                    if(bc.balances[widget.coin.asset_name]!=null){
                      double balance=bc.balances[widget.coin.asset_name]!.totalBalance!*bc.currentPrices[widget.coin.asset_name]!;
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
                            TextFormField(
                              cursorColor: themeController.isDark?Colors.amber:Colors.black54,
                              keyboardType: TextInputType.number,
                              controller: amountController,
                              decoration: textfieldDecoration.copyWith(fillColor: themeController.isDark?primary_color_light:Colors.grey[300],prefixText: "USD  ",prefixStyle: TextStyle(color: Colors.black54),hintText: " 0",hintStyle: TextStyle(color:Colors.black54)),
                              validator: (val)=>val!.isEmpty||double.parse(val)<=0?"Invalid ${widget.coin.asset_name} amount":null,
                              style: GoogleFonts.lato(
                                  color: themeController.isDark?Colors.white60:Colors.black54,
                                  fontSize: smallFont()
                              ),
                            ),
                            SizedBox(height: 10.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                    text: "Available balance",
                                    color: w_text_color,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start
                                ),
                                SmallText(
                                    text: CurrencyFormatter.format(balance, formatter),
                                    color: w_text_color,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start
                                ),

                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Row(
                              children: [
                                SizedBox(
                                  width: width*0.8,
                                  child: TextFormField(
                                    controller: addressController,
                                    cursorColor: themeController.isDark?Colors.amber:Colors.black54,
                                    decoration: textfieldDecoration.copyWith(fillColor: themeController.isDark?primary_color_light:Colors.grey[300],hintText: "Address",hintStyle: TextStyle(color:Colors.black54)),
                                    validator: (val)=>val!.isEmpty?"Invalid ${widget.coin.asset_name} address":null,
                                    style: GoogleFonts.lato(
                                        color: themeController.isDark?Colors.white60:Colors.black54,
                                        fontSize: smallFont()
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      FlutterClipboard.paste().then((value) {
                                        addressController.text=value;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.paste,
                                      color: Colors.amber,
                                      size: getsmallIconSize(),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 20.sp,),
                            MyButton(
                                text: "Send",
                                bgColor: button_color,
                                txtColor: w_text_color,
                                bgRadius: 4.sp,
                                verticalPadding: 15.sp,
                                width: width,
                                onPressed: ()async{
                                  if(_key.currentState!.validate()){
                                    context.loaderOverlay.show();
                                    double amount=double.parse(amountController.text.trim());
                                    log("Sending $amount ${widget.coin.asset_name}");
                                    if(amount<=balance){
                                      await tc.sendCoin(context: context, coinType: widget.coin.coinType!, coinName: widget.coin.asset_name, from: widget.coin.wallet_address!, to: addressController.text.trim(), privateKey: widget.coin.privateKey!, amount: amount);
                                    }else{
                                      ShowSnackBar.show(context, "insufficient balance", Colors.red);
                                    }
                                    context.loaderOverlay.hide();
                                  }
                                }
                            ),

                          ],
                        ),
                      );
                    }else{
                      return Center(
                        child: Loading(),
                      );
                    }
                  }
              ),
            ),
          ),
        );
      }
    );
  }
}
