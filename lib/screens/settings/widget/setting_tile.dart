import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class SettingsTile extends StatelessWidget {
  Color bgColor;
  String title;
  String leadingImage;
  String? trailing;
  Function onPressed;
  SettingsTile({required this.bgColor,required this.title, required this.leadingImage, this.trailing, leading,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ThemeController>(
        builder: (context,themeController,_) {
          return ListTile(
            onTap: (){
              onPressed.call();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.sp))
            ),
            tileColor: themeController.isDark?bgColor:Colors.white,
            leading: Image.asset(leadingImage,fit: BoxFit.contain,width: width*0.06,height: height*0.06,),
            title: SmallText(
                text: title,
                color: themeController.isDark?w60_text_color:lb_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
            ),
            trailing: SizedBox(
              width: width*0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  trailing!=null?SmallText(
                      text: trailing!,
                      color: themeController.isDark?w10_text_color:lb_text_color,
                      weight: FontWeight.normal,
                      align: TextAlign.start
                  ):const SizedBox(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: themeController.isDark?w_text_color:Colors.black54,
                    size: getsmallIconSize(),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
