import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class SmallText extends StatelessWidget {
  String text;
  Color color;
  FontWeight weight;
  TextAlign align;
  int? maxLines;
  SmallText({required this.text,required this.color,required this.weight,required this.align,this.maxLines,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return SizedBox(
          child: Text(
            text,
            maxLines: maxLines??1,
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
                fontWeight: weight,
              color: themeController.isDark?color:lb_text_color,
              fontSize: 11.sp,
            ),
          ),
        );
      }
    );
  }
}
