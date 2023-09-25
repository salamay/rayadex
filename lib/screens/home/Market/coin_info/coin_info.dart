import 'dart:developer';
import 'package:coingecko_api/data/market.dart';
import 'package:coingecko_api/data/market_chart_data.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Market/widget/chart.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/settings/widget/simple_tile.dart';
import '../../../../component/app_component.dart';
import '../../../widget/loading.dart';
import 'model/controller/coin_info_controller.dart';


class CoinInfo extends StatefulWidget {

  Market market;

  CoinInfo({required this.market});

  @override
  State<CoinInfo> createState() => _CoinInfoState();
}

class _CoinInfoState extends State<CoinInfo> {

  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );

  @override
  void initState() {
     // TODO: implement initState
    log(widget.market.id.toString());
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
                color: themeController.isDark?Colors.white:Colors.black,
                size: getBigIconSize(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            centerTitle: false,
            title: const Text(
                "Coin"
            ),
          ),
          body: Consumer<ThemeController>(
            builder: (context,themeController,_) {
              return Container(
                padding: EdgeInsets.all(8.sp),
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 0,right: 10.sp),
                            tileColor: themeController.isDark?primary_color:Colors.white,
                            leading: CircleAvatar(
                              backgroundColor: primary_color,
                              child: Image.network(widget.market.image!,fit: BoxFit.cover,),
                            ),
                            title: SmallText(
                                text: widget.market.name,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                align: TextAlign.start
                            ),
                            trailing: SmallText(
                              text: widget.market.marketCapRank!.toString(),
                              color: Colors.white60,
                              weight: FontWeight.normal,
                              align: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SmallText(
                                  text: CurrencyFormatter.format(widget.market.currentPrice, formatter),
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center
                              ),
                              SizedBox(width: width*0.01,),
                              widget.market.priceChangePercentage24h!.isNegative?SmallText(
                                  text: widget.market.priceChange24h!.toStringAsFixed(2),
                                  color: Colors.red,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center
                              ):SmallText(
                                  text: widget.market.priceChange24h!.toStringAsFixed(2),
                                  color: Colors.green,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center
                              ),
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        height: height*0.4,
                        width: width,
                        child: Consumer<CoinMarketController>(
                          builder: (context,cmc,child) {
                            return FutureBuilder<List<MarketChartData>?>(
                              future: Provider.of<CoinInfoController>(context,listen: false).coinMarketChart(widget.market.id, "usd",cmc.chartPeriod!.days,cmc.chartPeriod!.interval),
                              builder: (context,snapshot) {
                                if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                                  final data=snapshot.data!;
                                  log(data.length.toString());
                                  return SizedBox(
                                    child: CoinChart(data: data)
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
                            );
                          }
                        ),
                      ),
                      widget.market.marketCap !=null?SimpleTile(
                          bgColor: primary_color_light,
                          title: "Market Cap",
                          trailing: CurrencyFormatter.format(widget.market.marketCap!.toStringAsFixed(2), formatter),
                          leadingImage: null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp),topRight: Radius.circular(10.sp))
                          ),
                          onPressed: (){

                          }
                      ):const SizedBox(),
                      const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                      widget.market.circulatingSupply !=null?SimpleTile(
                          bgColor: primary_color_light,
                          title: "Circulating supply",
                          trailing: CurrencyFormatter.format(widget.market.circulatingSupply!.toStringAsFixed(2), formatter),
                          leadingImage: null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0))
                          ),
                          onPressed: (){

                          }
                      ):const SizedBox(),
                      widget.market.currentPrice !=null?SimpleTile(
                          bgColor: primary_color_light,
                          title: "Circulating supply",
                          trailing: CurrencyFormatter.format(widget.market.currentPrice!.toStringAsFixed(2), formatter),
                          leadingImage: null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0))
                          ),
                          onPressed: (){

                          }
                      ):const SizedBox(),
                      const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                      SimpleTile(
                          bgColor: primary_color_light,
                          title: "Current price",
                          trailing: CurrencyFormatter.format(widget.market.currentPrice, formatter),
                          leadingImage: null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0))
                          ),
                          onPressed: (){

                          }
                      ),
                      const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                      widget.market.priceChangePercentage24h !=null?SimpleTile(
                          bgColor: primary_color_light,
                          title: "Price change percentage 24h",
                          trailing: CurrencyFormatter.format(widget.market.priceChangePercentage24h!.toStringAsFixed(2), formatter),
                          leadingImage: null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0))
                          ),
                          onPressed: (){

                          }
                      ):const SizedBox(),
                      const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                      SimpleTile(
                          bgColor: primary_color_light,
                          title: "Market cap rank",
                          trailing: widget.market.marketCapRank.toString(),
                          leadingImage: null,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0))
                          ),
                          onPressed: (){

                          }
                      ),
                      const Divider(color: Colors.white24,height: 0.5,thickness: 0.5,),
                      widget.market.totalVolume != null?SimpleTile(
                          bgColor: primary_color_light,
                          title: "Total volume",
                          trailing: CurrencyFormatter.format(widget.market.totalVolume!.toStringAsFixed(2), formatter),
                          leadingImage: null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp),bottomRight: Radius.circular(10.sp))
                          ),
                          onPressed: (){

                          }
                      ):const SizedBox(),
                    ],
                  ),
                ),
              );
            }
          ),
        );
      }
    );
  }
}
