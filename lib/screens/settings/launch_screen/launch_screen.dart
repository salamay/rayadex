import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';

import '../../../component/app_component.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

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
            title: Text(
              "Launch screen",
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
                    title: "Auto",
                    leadingImage: 'assets/icon/settings.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Balance",
                    leadingImage: 'assets/icon/credit_card.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Market overview",
                    leadingImage: 'assets/icon/manage_wallet.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "Watch address",
                    leadingImage: 'assets/icon/eye.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){

                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
