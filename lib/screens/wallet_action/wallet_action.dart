import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/button/MyButton.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';

class WalletAction extends StatefulWidget {
  const WalletAction({Key? key}) : super(key: key);

  @override
  State<WalletAction> createState() => _WalletActionState();
}

class _WalletActionState extends State<WalletAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10.sp),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset("assets/logo.png",fit: BoxFit.contain,width: width*0.3,height: height*0.2,),
            SizedBox(height: height*0.15,),
            MyButton(
              text: "Create",
              bgColor: button_color,
              txtColor: w_text_color,
              bgRadius: 4.sp,
              verticalPadding: 15.sp,
              width: width,
              onPressed: (){
                  Navigator.pushNamed(context, AppRoute.newWallet);
              },
            ),
            SizedBox(height: height*0.03,),
            MyButton(
                text: "Restore",
              bgColor: button_color,
              txtColor: w_text_color,
              bgRadius: 4.sp,
              verticalPadding: 15.sp,
              width: width,
              onPressed: (){
                Navigator.pushNamed(context, AppRoute.importWallet);
                // chooseImportOption(context);
              },
            ),
            // SizedBox(height: height*0.03,),
            // MyButton(
            //     text: "Watch Address",
            //     bgColor: primary_color,
            //     txtColor: w_text_color,
            //     bgRadius: 0,
            //     height: button_height,
            //     width: button_width,
            //   onPressed: (){
            //
            //   },
            // ),
            SizedBox(height: height*0.1,),
          ],
        ),
      ),
    );
  }

  void chooseImportOption(context){
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: height*0.2,
        padding: EdgeInsets.all(8.sp),
        color: primary_color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, AppRoute.importWallet);
              },
              leading: Icon(
                Icons.import_export,
                color: Colors.grey[300],
                size: getBigIconSize(),
              ),
              title: SmallText(
                  text: "By mnemonics",
                  color: w60_text_color,
                  weight: FontWeight.bold,
                  align: TextAlign.start
              ),
              trailing:  Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[300],
                size: getBigIconSize(),
              ),
            ),
            SizedBox(height: 10.sp,),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, AppRoute.importByPrivateKey);
              },
              leading: Icon(
                Icons.import_export,
                color: Colors.grey[300],
                size: getBigIconSize(),
              ),
              title: SmallText(
                  text: "By private key",
                  color: w60_text_color,
                  weight: FontWeight.bold,
                  align: TextAlign.start
              ),
              trailing:  Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[300],
                size: getBigIconSize(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
