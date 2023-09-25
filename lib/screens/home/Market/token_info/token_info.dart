import 'dart:developer';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/coin.dart';
import 'package:coingecko_api/data/market_chart_data.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Market/token_info/model/TokenData.dart';
import 'package:ryipay/screens/home/Market/token_info/token_chart_two.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';
import '../../../../component/app_component.dart';
import '../../../widget/loading.dart';
import 'Controller/TokenDataController.dart';


class TokenInfo extends StatefulWidget {
  SupportedCoin asset;

  TokenInfo({required this.asset});

  @override
  State<TokenInfo> createState() => _TokenInfoState();
}

class _TokenInfoState extends State<TokenInfo> {
  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );
  final _coinGecko=CoinGeckoApi();
  @override
  void initState() {
    // TODO: implement initState

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: getBigIconSize(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            centerTitle: false,
            title: Text(
                widget.asset.asset_name,
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(8.sp),
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.01,),
                  SizedBox(
                    height: height*0.4,
                    child: Consumer<CoinMarketController>(
                        builder: (context,cmc,child) {
                          return FutureBuilder<CoinGeckoResult<List<MarketChartData>>>(
                            future: _coinGecko.contract.getContractMarketChartRanged(id: widget.asset.tokenChainId!, contractAddress: widget.asset.contractAddress!, vsCurrency: "usd", from: DateTime.fromMillisecondsSinceEpoch(cmc.timestampFrom!), to: DateTime.fromMillisecondsSinceEpoch(cmc.timestampTo!),),
                            builder: (context,snapshot){
                              if(snapshot.hasData&&snapshot.connectionState==ConnectionState.done){
                                List<MarketChartData> market=snapshot.data!.data;
                                log("Length: ${market.length.toString()}");
                                return market.isNotEmpty?SizedBox(
                                    child: TokenChartTwo(data: market)
                                ):Container(
                                  padding: EdgeInsets.all(10.sp),
                                  child: SmallText(
                                    text: "Market data not available at the moment",
                                    color: w60_text_color,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                );;
                              }else if(snapshot.hasError){
                                return Container(
                                  padding: EdgeInsets.all(10.sp),
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
                            },
                          );
                        }
                    ),
                  ),
                  SizedBox(
                    child: Consumer<CoinMarketController>(
                        builder: (context,cmc,child) {
                          return FutureBuilder<TokenData>(
                            future: TokenDataController().getTokenData(context,widget.asset.tokenChainId!,widget.asset.contractAddress!),
                            builder: (context,snapshot){
                              if(snapshot.hasData&&snapshot.connectionState==ConnectionState.done){
                                TokenData coin=snapshot.data!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SimpleTile(
                                    //     bgColor: primary_color_light,
                                    //     title: "Current price",
                                    //     trailing: CurrencyFormatter.format(coin.marketData..toStringAsFixed(2), formatter),
                                    //     leadingImage: null,
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                    //     ),
                                    //     onPressed: (){
                                    //
                                    //     }
                                    // ),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Current price",
                                        trailing: CurrencyFormatter.format(coin.marketData!.currentPrice['usd'], formatter,decimal: 5),
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 24H",
                                        trailing: "${coin.marketData!.priceChangePercentage24HInCurrency['usd']!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 7d",
                                        trailing: "${coin.marketData!.priceChangePercentage7D!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 14d",
                                        trailing: "${coin.marketData!.priceChangePercentage14D!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 30d",
                                        trailing: "${coin.marketData!.priceChangePercentage30DInCurrency['usd']!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 60d",
                                        trailing: "${coin.marketData!.priceChangePercentage60DInCurrency['usd']!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Price change 1y",
                                        trailing: "${coin.marketData!.priceChangePercentage1YInCurrency['usd']!.toStringAsFixed(1)}%",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "24H low / 24H high",
                                        trailing: "${CurrencyFormatter.format(coin.marketData!.low24H['usd'], formatter,decimal: 5)} / ${CurrencyFormatter.format(coin.marketData!.low24H['usd'], formatter,decimal: 5)}",
                                        leadingImage: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                                        ),
                                        onPressed: (){

                                        }
                                    ),

                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Total supply",
                                        trailing: CurrencyFormatter.format(coin.marketData!.totalSupply, formatter),
                                        leadingImage: null,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(0))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Contract address",
                                        trailing: coin.contractAddress.toString(),
                                        leadingImage: null,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(0))
                                        ),
                                        onPressed: (){

                                        }
                                    ),
                                    const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                                    SimpleTile(
                                        bgColor: primary_color_light,
                                        title: "Symbol",
                                        trailing: coin.symbol.toString(),
                                        leadingImage: null,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(0))
                                        ),
                                        onPressed: (){

                                        }
                                    ),

                                  ],
                                );
                              }else if(snapshot.hasError){
                                return Container(
                                  padding: EdgeInsets.all(10.sp),
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
                            },
                          );
                        }
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
