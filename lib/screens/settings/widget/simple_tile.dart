import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';

import '../../../component/app_component.dart';
class SimpleTile extends StatelessWidget {
  Color bgColor;
  String title;
  String? leadingImage;
  ShapeBorder shape;
  Function onPressed;
  String? trailing;
  SimpleTile({required this.bgColor,required this.title, this.leadingImage,required this.shape,required this.onPressed,this.trailing});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return SizedBox(
          child: leadingImage!=null?ListTile(
            onTap: (){
              print("on Tap");
              onPressed.call();
            },
            shape: shape,
            tileColor: themeController.isDark?bgColor:Colors.white,
            leading: Image.asset(leadingImage!,fit: BoxFit.contain,width: width*0.06,height: height*0.06,),
            title: SmallText(
                text: title,
                color: themeController.isDark?Colors.white:lb_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
            ),
            trailing: trailing!=null? SmallText(
                text: "\$ $trailing",
                color: themeController.isDark?Colors.white:lb_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
            ):const SizedBox(),
          ):ListTile(
            onTap: (){
              print("on Tap");
              onPressed.call();
            },
            shape: shape,
            tileColor: themeController.isDark?primary_color_light:Colors.white,
            title: SmallText(
                text: title,
                color: themeController.isDark?Colors.white:lb_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
            ),
            trailing: trailing!=null?SmallText(
                text: "$trailing",
                color: themeController.isDark?Colors.white:lb_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
            ):const SizedBox(),
          ),
        );
      }
    );
  }
}
