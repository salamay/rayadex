import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';
class BaseCurrency extends StatelessWidget {
  const BaseCurrency({Key? key}) : super(key: key);

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
              "Base currency",
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
                    title: "USD",
                    leadingImage: 'assets/icon/icons8_usa_480px 1.png',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "CHF",
                    leadingImage: 'assets/icon/icons8_switzerland_480px 1.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "GBP",
                    leadingImage: 'assets/icon/icons8_great_britain_500px 1.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "JPY",
                    leadingImage: 'assets/icon/icons8_japan_480px 1.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "AUD",
                    leadingImage: 'assets/icon/icons8_australia_480px 1.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "BRL",
                    leadingImage: 'assets/icon/icons8_brazil_480px 1.png',
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))
                    ),
                    onPressed: (){

                    },
                  ),
                  const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                  SimpleTile(
                    bgColor: primary_color_light,
                    title: "CAD",
                    leadingImage: 'assets/icon/icons8_canada_480px 1.png',
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
