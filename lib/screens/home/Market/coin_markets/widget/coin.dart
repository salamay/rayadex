import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class Coin extends StatelessWidget {
  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );

  String assetName;
  String assetSymbol;
  double price;
  double priceChange;
  String coinImage;
  Color bgColor;
  Coin({required this.assetName,required this.assetSymbol, required this.price, required this.priceChange,required this.coinImage,required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return SizedBox(
          child: Column(
            children: [
              ListTile(
                tileColor: themeController.isDark?primary_color:Colors.white,
                leading: CircleAvatar(
                  radius: 15.sp,
                  backgroundColor: themeController.isDark?primary_color:Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: coinImage,
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    placeholder: (context, url) => SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: CircularProgressIndicator(
                          color: primary_color_light,
                        )
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                title: MediumText(
                    text: assetName,
                    color: Colors.white,
                    weight: FontWeight.normal,
                    align: TextAlign.start
                ),
                subtitle: SmallText(
                  text: assetSymbol,
                  color: Colors.white70,
                  weight: FontWeight.bold,
                  align: TextAlign.start,
                ),
                trailing: SizedBox(
                  width: width*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end
                    ,
                    children: [
                      SmallText(
                        text: CurrencyFormatter.format(price, formatter),
                        color: Colors.white,
                        weight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      SizedBox(height: 1.sp,),
                      priceChange.isNegative?SmallText(
                        text: "${priceChange.toStringAsFixed(2)}\%",
                        color: Colors.red,
                        weight: FontWeight.bold,
                        align: TextAlign.start,
                      ):SmallText(
                        text: "+${priceChange.toStringAsFixed(2)}\%",
                        color: Colors.green,
                        weight: FontWeight.bold,
                        align: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 0.5.sp,color: Colors.white38,)
            ],
          ),
        );
      }
    );
  }
}
