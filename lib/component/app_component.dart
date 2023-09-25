import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

////////////////////////TEXT//////////////////////////////////////////////////
const Color w60_text_color=Colors.white60;
const Color w10_text_color=Colors.white10;
const Color w_text_color=Colors.white;
const Color b_text_color=Colors.black;
const Color lb_text_color=Colors.black54;
const Color lb87_text_color=Colors.black54;
double height=1.sh;
double width=1.sw;
double button_height=height*0.08;
double button_width=width*0.75;
double smallFont(){
  return 11.sp;
}
double mediumFont(){
  return 16.sp;
}
double largeFont(){
  return 24.sp;
}
double verylargeFont(){
  return 28.sp;
}

////////////////////////////////////BUTTON////////////////////////////////////
HexColor primary_color= HexColor("#000000");
HexColor bottom_bar= HexColor("#282626");
Color icon_color= Colors.white60;
HexColor primary_color_light= HexColor("#262834");
HexColor primary_color_button= HexColor("#082263");
HexColor button_color= HexColor("#0f69fe");

//Border radius
double getSmallBorderRadiusSize(){
  return 10.sp;
}
double getMediumBorderRadiusSize(){
  return 15.sp;
}
double getLargeBorderRadiusSize(){
  return 25.sp;
}

//Icon
double getsmallIconSize(){
  return 15.sp;
}
double getBigIconSize(){
  return 20.sp;
}
final InputDecoration textfieldDecoration=InputDecoration(
  fillColor: primary_color,
  filled: true,
  hoverColor: Colors.white60,
  hintStyle: GoogleFonts.lato(
    fontWeight: FontWeight.normal,
    color: w10_text_color,
  ),

  focusedBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
    borderSide: const BorderSide(
        color: w10_text_color,
        width: 0.2
    ),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
    borderSide: const BorderSide(
      color: w10_text_color,
      width: 0.2,
    ),
  ),
    errorStyle: GoogleFonts.lato(
        fontWeight: FontWeight.normal,
        color: Colors.redAccent,
        fontSize: smallFont()
    ),
  prefixStyle: GoogleFonts.lato(
  fontWeight: FontWeight.bold,
  color: Colors.amber,
),

);