import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/component/texts/constants.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';

class ManageWallet extends StatelessWidget {
  late WalletController wc;

  @override
  Widget build(BuildContext context) {
    wc=Provider.of<WalletController>(context,listen: false);
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
            title: Text(
              "Manage wallets",
              style: TextStyle(
                  fontSize: 24.sp
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Change wallet",
                    leadingImage: 'assets/icon/white_menu.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoute.changeWallet);
                    },
                  ),                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Create",
                    leadingImage: 'assets/icon/plus.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoute.newWallet);
                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Restore",
                    leadingImage: 'assets/icon/download.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){
                      chooseImportOption(context);
                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Backup",
                    leadingImage: 'assets/icon/eye.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoute.backup);
                    },
                  ),
                  SizedBox(height: height*0.1,),
                  SmallText(
                    text: manage_wallet_desc,
                    color: w10_text_color,
                    weight: FontWeight.normal,
                    align: TextAlign.start,
                    maxLines: 15,
                  ),

                ],
              ),
            ),
          ),
        );
      }
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
          ],
        ),
      ),
    );
  }
}
