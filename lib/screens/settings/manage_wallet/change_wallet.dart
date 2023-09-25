import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/wallet_model.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';

class ChangeWallet extends StatelessWidget {
  ChangeWallet({Key? key}) : super(key: key);
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
                "Select wallet",
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
                  children: wc.wallets!.map((WalletModel item) {
                    return ListTile(
                      onTap: ()async{
                        await wc.changeWallet(item);
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.wallet_outlined,
                        color: icon_color,
                        size: 15.sp,
                      ),
                      title: SmallText(
                          text: item.wallet_name,
                          color: w_text_color,
                          weight: FontWeight.normal,
                          align: TextAlign.start
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: icon_color,
                        size: 15.sp,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
    );
  }
}
