import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/setting_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 24.sp
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SettingsTile(
                      bgColor: primary_color_light,
                      title: "Manage wallet",
                      trailing: null,
                    leadingImage: 'assets/icon/manage_wallet.png',
                    onPressed: (){
                        Navigator.pushNamed(context, AppRoute.manageWallets);
                    },
                  ),
                  smallBox(),
                  SettingsTile(
                    bgColor: primary_color_light,
                    title: "Security center",
                    trailing: null,
                    leadingImage: 'assets/icon/security_center.png',
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoute.appSecurity);

                    },
                  ),

                  smallBox(),
                  SettingsTile(
                    bgColor: primary_color_light,
                    title: "About app",
                    trailing: null,
                    leadingImage: 'assets/icon/launch_screen.png',
                    onPressed: (){
                      // Navigator.pushNamed(context, AppRoute.aboutApp);
                    },
                  ),
                  SizedBox(height: height*0.1,),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MediumText(
                            text: "RAYADEX",
                            color: themeController.isDark?w_text_color:lb_text_color,
                            weight: FontWeight.bold,
                            align: TextAlign.center
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child:  SmallText(
                              text: "decentralize app",
                              color: themeController.isDark?w60_text_color:lb_text_color,
                              weight: FontWeight.normal,
                              align: TextAlign.center
                          ),
                        ),
                        Image.asset("assets/logo.png",fit: BoxFit.contain,width: width*0.3,height: height*0.1,),

                      ],
                    ),
                  )// SizedBox(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //
                  //       Image.asset("assets/logo.png",fit: BoxFit.contain,width: width*0.3,height: height*0.1,),
                  //
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  Widget smallBox(){
    return SizedBox(height: 10.sp,);
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url,),mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
