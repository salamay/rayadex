import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class LargeText extends StatelessWidget {
  String text;
  Color color;
  FontWeight weight;
  TextAlign align;
  int? maxLines;
  LargeText({required this.text,required this.color,required this.weight,required this.align,this.maxLines,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return SizedBox(
          child: Text(
            text,
            textAlign: align,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
                fontWeight: weight,
                color: themeController.isDark?color:lb_text_color,
                fontSize: 24.sp
            ),
          ),
        );
      }
    );
  }
}
