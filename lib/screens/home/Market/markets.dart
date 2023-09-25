import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/coin_markets/coin_markets.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';

import 'news/news.dart';
class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Market",
                style: TextStyle(
                    fontSize: 24.sp
                ),
              ),
              bottom: TabBar(
                indicatorColor: themeController.isDark?Colors.white60:Colors.black54,
                tabs: [
                  Tab(child: SmallText(text: "Overview", color: w60_text_color, weight: FontWeight.normal, align: TextAlign.center),),
                  Tab(child: SmallText(text: "News", color: w60_text_color, weight: FontWeight.normal, align: TextAlign.center),),
                  // Tab(child: SmallText(text: "Watches", color: w60_text_color, weight: FontWeight.normal, align: TextAlign.center),),
                ],
              ),
            ),
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                CoinMarkets(),
                News()
              ],
            ),
          ),
        );
      }
    );
  }
}
