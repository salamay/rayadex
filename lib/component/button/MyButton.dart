import 'package:flutter/material.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';

class MyButton extends StatelessWidget {
  String text;
  Color bgColor;
  Color txtColor;
  double bgRadius;
  double verticalPadding;
  double? width;
  Function onPressed;
  MyButton({required this.text, required this. bgColor,required this.txtColor, required this.bgRadius,required this.verticalPadding, this.width,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(bgRadius)),
              side: BorderSide(
                  color: button_color,
                  width: 1
              )
          ),
          elevation: 0,
        ),
        child:Padding(
          padding: EdgeInsets.only(top: verticalPadding,bottom: verticalPadding),
          child: MediumText(
              text: text,
              color: txtColor,
              weight: FontWeight.w500,
              align: TextAlign.center
          ),
        ),
      ),
    );
  }
}
