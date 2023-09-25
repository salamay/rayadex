import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class GlobalMarketCap extends StatelessWidget {
  String title;
  double price;
  double percentage;
  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );
  GlobalMarketCap({required this.title, required this.price, required this.percentage});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Container(
          height: height*0.12,
          width: width*0.45,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: themeController.isDark?primary_color_light:Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10.sp))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                  text: title,
                  color: w60_text_color,
                  weight: FontWeight.normal,
                  align: TextAlign.start
              ),
              const Spacer(),
              SmallText(
                  text: CurrencyFormatter.format(price.toStringAsFixed(2), formatter),
                  color: w_text_color,
                  weight: FontWeight.bold,
                  align: TextAlign.start
              ),
              percentage.isNegative?SmallText(
                text: "${percentage.toStringAsFixed(2)}\%",
                color: Colors.red,
                weight: FontWeight.bold,
                align: TextAlign.start,
              ):SmallText(
                text: "+${percentage.toStringAsFixed(2)}\%",
                color: Colors.green,
                weight: FontWeight.bold,
                align: TextAlign.start,
              )
            ],
          ),
        );
      }
    );
  }
}
