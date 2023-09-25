import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/component/Apptheme.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/main.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';
class MyTheme extends StatelessWidget {
  bool isLight = false;
  late ThemeController themeController;
  @override
  Widget build(BuildContext context) {
    themeController=Provider.of<ThemeController>(context,listen: false);
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
          "Theme",
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
              SizedBox(height: height*0.02,),
              SimpleTile(
                bgColor: primary_color_light,
                title: "Dark",
                leadingImage: 'assets/icon/moon.png',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                ),
                onPressed: (){
                  themeController.changeTheme(true);
                },
              ),
              const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
              SimpleTile(
                bgColor: primary_color_light,
                title: "Light",
                leadingImage: 'assets/icon/sun.png',
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))
                ),
                onPressed: (){
                  themeController.changeTheme(false);
                },
              ),
              // const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
              // SimpleTile(
              //   bgColor: primary_color_light,
              //   title: "System",
              //   leadingImage: 'assets/icon/settings.png',
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
              //   ),
              //   onPressed: (){
              //
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
