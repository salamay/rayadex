import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsWidget extends StatelessWidget {
  String title;
  String content;
  DateTime date;
  NewsWidget({required this.title, required this.content, required this.date});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Container(
          padding: EdgeInsets.all(10.sp),
          margin: EdgeInsets.only(bottom: 10.sp),
          decoration: BoxDecoration(
            color: themeController.isDark?primary_color_light:Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.sp,),
              SmallText(
                text: title,
                color: w60_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start,
                maxLines: 2,
              ),
              SizedBox(height: 10.sp,),
              SmallText(
                text: content,
                color: w60_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start,
                maxLines: 1,
              ),
              SizedBox(height: 10.sp,),
              SmallText(
                text: timeago.format(date, locale: 'en'),
                color: w60_text_color,
                weight: FontWeight.normal,
                align: TextAlign.start
                ,
                maxLines: 1,
              ),
            ],
          ),
        );
      }
    );
  }
}
