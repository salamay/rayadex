import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Market/coin_markets/widget/coin.dart';
class TopGainers extends StatelessWidget {
  List<Market> topGainers;
  TopGainers({required this.topGainers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
              size: getBigIconSize(),
            ),
            onPressed: () {
              Navigator.pop(context);
            },

          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.sp),
        height: height,
        width: width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediumText(text: "Top coins", color: w_text_color, weight: FontWeight.normal, align: TextAlign.start),
              SizedBox(height: height*0.01,),
              SmallText(text: "Top cons by market cap rank", color: w60_text_color, weight: FontWeight.normal, align: TextAlign.start),
              SizedBox(height: height*0.01,),
              Column(
                children: topGainers.map((e) => GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoute.coinInfo,arguments: e);
                  },
                  child: Coin(
                      assetName: e.name,
                      assetSymbol: e.symbol,
                      price: e.currentPrice!,
                      priceChange: e.priceChangePercentage24h!,
                      coinImage: e.image!,
                    bgColor: primary_color,
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
