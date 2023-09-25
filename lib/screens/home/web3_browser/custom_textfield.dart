import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryipay/component/app_component.dart';


class AuthTextField extends StatelessWidget {
  //final Function(String) validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String error;
  final String Function(String?) validFunction;
  final Function(String)? onSavedFunction;
  final Function(String)? onSubmitFunction;
  final Color? color;
  final Color? hintColor;
  final Color? fillColor;
  final bool? enabled;
  final double? height;
  const AuthTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.error,
    required this.validFunction,
    this.onSavedFunction,
    this.color,
    this.onSubmitFunction,
    this.enabled = true,
    this.height,
    this.hintColor,
    this.fillColor,
    //required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height ?? 65.sp,
      width: size.width,
      decoration: BoxDecoration(
          color: color ?? Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.sp)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          validator: validFunction,
          onChanged: onSavedFunction,
          onFieldSubmitted: onSubmitFunction,
          keyboardType: inputType,
          showCursor: true,
          cursorColor: primary_color,
          //validator: validator,
          style: TextStyle(color: w60_text_color),
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(color: hintColor ?? w60_text_color),

            // hintStyle: GoogleFonts.sansita(
            //   color: kWhite,
            // ),

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  //final Function(String) validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String error;
  final String Function(String?) validFunction;
  final Function(String)? onSavedFunction;
  final Function(String)? onSubmitFunction;
  final Color? color;
  final Color? hintColor;
  final Color? fillColor;
  final bool? enabled;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.inputType,
      required this.error,
      required this.validFunction,
      this.onSavedFunction,
      this.color,
      this.onSubmitFunction,
      this.enabled = true,
      this.height,
      this.hintColor,
      this.obscureText,
      this.fillColor,
      this.prefixIcon,
      this.suffixIcon
      //required this.validator,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      validator: validFunction,
      onChanged: onSavedFunction,
      onFieldSubmitted: onSubmitFunction,
      keyboardType: inputType,
      showCursor: true,
      cursorColor: primary_color,
      obscureText: obscureText ?? false,
      //validator: validator,
      style: TextStyle(
        color: w_text_color,
        fontSize: 15.sp,
      ),
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // labelText: hint,
        // labelStyle: const TextStyle(color: kTextSubtitleColor),
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor ?? w60_text_color,
          fontSize: 15.sp,
        ),

        // hintStyle: GoogleFonts.sansita(
        //   color: kWhite,
        // ),

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(
            color: primary_color,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
