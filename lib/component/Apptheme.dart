import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ryipay/component/app_component.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: primary_color,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: mediumFont()
      ),
      backgroundColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white60,
      filled: true,
      hoverColor: Colors.white60,
      hintStyle: GoogleFonts.lato(
        fontWeight: FontWeight.normal,
        color: w10_text_color,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        borderSide: const BorderSide(
            color: w10_text_color,
            width: 0.2
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        borderSide: const  BorderSide(
          color: w10_text_color,
          width: 0.2,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide:  BorderSide(
          color: Colors.amber,
          width: 0.2,
        ),
      )
    )
  );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: mediumFont()
        ),
        backgroundColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white60,
          filled: true,
          hoverColor: Colors.grey,
          hintStyle: GoogleFonts.lato(
            fontWeight: FontWeight.normal,
            color: lb_text_color,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
            borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.2
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
            borderSide: const  BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide:  BorderSide(
              color: Colors.amber,
              width: 0.2,
            ),
          )
      )
  );
}