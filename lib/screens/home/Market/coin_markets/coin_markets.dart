import 'dart:developer';

import 'package:async/async.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/global_coin_data.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Market/coin_markets/widget/coin.dart';
import 'package:ryipay/screens/home/Market/coin_markets/widget/global_cap.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';
class CoinMarkets extends StatefulWidget {
  const CoinMarkets({Key? key}) : super(key: key);

  @override
  State<CoinMarkets> createState() => _CoinMarketsState();
}

class _CoinMarketsState extends State<CoinMarkets> with AutomaticKeepAliveClientMixin {
  final coinGeckoApi = CoinGeckoApi();
  AsyncMemoizer asyncMemoizer=AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Consumer<ThemeController>(
        builder: (context,themeController,_) {
          return Container(
            padding: EdgeInsets.all(8.sp),
            width: width,
            height: height,
            child: RefreshIndicator(
              backgroundColor: primary_color,
              color: Colors.white,
              onRefresh: ()async{
                asyncMemoizer=AsyncMemoizer();
                setState(() {

                });
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    FutureBuilder<CoinGeckoResult<GlobalCoinData?>>(
                      future: coinGeckoApi.global.getGlobalData(),
                      builder: (context,snapshot) {
                        if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                          GlobalCoinData data=snapshot.data!.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GlobalMarketCap(
                                title: "Total Market Cap",
                                price: data.totalMarketCap!['btc']!,
                                percentage: data.marketCapPercentage!['btc']!,
                              ),
                              SizedBox(width: width*0.05,),
                              GlobalMarketCap(
                                title: "Total Volume",
                                price: data.totalVolume!['btc']!,
                                percentage: data.totalVolume!['btc']!,
                              )
                            ],
                          );
                        }else if(snapshot.hasError){
                          return SizedBox(
                            child: SmallText(
                              text: "Unable to get market data",
                              color: w60_text_color,
                              weight: FontWeight.normal,
                              align: TextAlign.center,
                              maxLines: 2,
                            ),
                          );
                        }else{
                          return const Loading();
                        }
                      }
                    ),
                    FutureBuilder<dynamic>(
                        future: asyncMemoizer.runOnce(() => coinGeckoApi.coins.listCoinMarkets(vsCurrency: "usd")),
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                            List<Market> topGainers=[];
                            List<Market> topLoosers=[];
                            topGainers.addAll(snapshot.data!.data);
                            topLoosers.addAll(snapshot.data!.data);
                            topGainers.sort((a,b)=>b.priceChangePercentage24h!.compareTo(a.priceChangePercentage24h!));
                            topLoosers.sort((a,b)=>a.priceChangePercentage24h!.compareTo(b.priceChangePercentage24h!));
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(0.sp),
                                  leading: Icon(
                                    Icons.arrow_upward_outlined,
                                    size: getsmallIconSize(),
                                    color: themeController.isDark?Colors.white:lb_text_color,
                                  ),
                                  title: SmallText(
                                      text: "Top gainers",
                                      color: w_text_color,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start
                                  ),
                                  trailing: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, AppRoute.allTopGainers,arguments: topGainers);
                                    },
                                    child: Container(
                                        width:width*0.2,
                                        decoration: BoxDecoration(
                                            color: themeController.isDark?primary_color_light:Colors.grey[300],
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SmallText(
                                              text: "See all",
                                              color: Colors.white,
                                              weight: FontWeight.bold,
                                              align: TextAlign.center
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration:BoxDecoration(
                                    color: themeController.isDark?primary_color_light:Colors.grey[300],
                                    borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                  ),
                                  child: Column(
                                    children: topGainers.sublist(0,6).map((e) => GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, AppRoute.coinInfo,arguments: e);
                                      },
                                      child: Coin(
                                          assetName: e.name,
                                          assetSymbol: e.symbol,
                                          price: e.currentPrice!,
                                          priceChange: e.priceChangePercentage24h!,
                                          coinImage: e.image!,
                                        bgColor: primary_color_light,
                                      ),
                                    )).toList(),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0.sp),
                                  leading: Icon(
                                    Icons.arrow_upward_outlined,
                                    size: getsmallIconSize(),
                                    color: themeController.isDark?Colors.white:Colors.black54,
                                  ),
                                  title: SmallText(
                                      text: "Top loosers",
                                      color: w_text_color,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start
                                  ),
                                  trailing: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, AppRoute.allTopLoosers,arguments: topLoosers);
                                    },
                                    child: Container(
                                        width:width*0.2,
                                        decoration: BoxDecoration(
                                            color: themeController.isDark?primary_color_light:Colors.grey[300],
                                            borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SmallText(
                                              text: "See all",
                                              color: Colors.white,
                                              weight: FontWeight.bold,
                                              align: TextAlign.center
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration:BoxDecoration(
                                      color: themeController.isDark?primary_color_light:Colors.grey[300],
                                      borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                  ),
                                  child: Column(
                                    children: topLoosers.sublist(0,6).map((e) => GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, AppRoute.coinInfo,arguments: e);
                                      },
                                      child: Coin(
                                          assetName: e.name,
                                          assetSymbol: e.symbol,
                                          price: e.currentPrice!,
                                          priceChange: e.priceChangePercentage24h!,
                                          coinImage: e.image!,
                                        bgColor: primary_color_light,
                                      ),
                                    )).toList(),
                                  ),
                                ),
                              ],
                            );
                          }else if(snapshot.hasError){
                            return SizedBox(
                              child: SmallText(
                                text: "Unable to get market data",
                                color: w60_text_color,
                                weight: FontWeight.normal,
                                align: TextAlign.center,
                                maxLines: 2,
                              ),
                            );
                          }else{
                            return const Loading();
                          }
                        }
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
