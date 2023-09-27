
import 'dart:developer';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/button/MyButton.dart';
import 'package:ryipay/component/texts/LargeText.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/BalanceController.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';
import 'model/balance_model/balance_model.dart';
import 'model/supported_coin.dart';

class Wallets extends StatefulWidget {
  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {

  CurrencyFormatterSettings dollarConverter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );

  CurrencyFormatterSettings formatter = CurrencyFormatterSettings(
    symbol: '\$',
    symbolSide: SymbolSide.left,
    thousandSeparator: ',',
    decimalSeparator: '.',
    symbolSeparator: ' ',
  );

  late WalletController _walletController;

  late CoinMarketController _coinMarketController;

  final _coinGecko=CoinGeckoApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _walletController=Provider.of<WalletController>(context,listen: false);
    _coinMarketController=Provider.of<CoinMarketController>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: MediumText(
              text: "My wallets",
              color: Colors.white,
              weight: FontWeight.normal,
              align: TextAlign.start,
              maxLines: 2,
            ),
            actions: [
              // IconButton(
              //     onPressed: ()async{
              //       dynamic result=await Navigator.pushNamed(context, AppRoute.addToken);
              //       await _walletController.getSupportedCoin();
              //       _walletController.refresh();
              //     },
              //     icon: Icon(
              //       Icons.add,
              //       color: themeController.isDark?Colors.white:Colors.black,
              //       size: getBigIconSize(),
              //     )
              // )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(8.sp),
            height: height,
            width: width,
            child: RefreshIndicator(
              onRefresh: ()async{
                Provider.of<BalanceController>(context,listen: false).getBalances(context);
                setState(() {

                });
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Consumer<WalletController>(
                  builder: (context,wc,_) {
                    return Consumer<BalanceController>(
                      builder: (context,bc,_) {
                        SupportedCoin? asset=wc.getAssets(CoinName.XRP.name);
                        return SizedBox(
                          height: height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              bc.balances[asset!.asset_name]!=null?LargeText(
                                text: "XRP ${bc.balances[asset.asset_name]!.totalBalance}",
                                color: w_text_color,
                                weight: FontWeight.bold,
                                align: TextAlign.start,
                                maxLines: 1,
                              ):Loading(),
                              SizedBox(height: 10.sp,),
                              bc.balances[asset.asset_name]!=null&&bc.currentPrices[asset.asset_name]!=null?MediumText(
                                text: CurrencyFormatter.format(bc.currentPrices[asset.asset_name]!*bc.balances[asset.asset_name]!.totalBalance!, dollarConverter),
                                color: w_text_color,
                                weight: FontWeight.bold,
                                align: TextAlign.start,
                                maxLines: 1,
                              ):Loading(),
                              SizedBox(height: height*0.05,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[500],
                                    radius: 25.sp,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.save_alt,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async{
                                        SupportedCoin? asset=await wc.getAssets(CoinName.XRP.name);
                                        Navigator.pushNamed(context, AppRoute.receivePage,arguments: asset);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15.sp,),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[500],
                                    radius: 25.sp,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.outbond_outlined,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async{
                                        SupportedCoin? asset=await wc.getAssets(CoinName.XRP.name);
                                        Navigator.pushNamed(context, AppRoute.sendPage,arguments: asset);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15.sp,),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[500],
                                    radius: 25.sp,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.menu_book,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async{
                                        SupportedCoin? asset=await wc.getAssets(CoinName.XRP.name);
                                        Navigator.pushNamed(context, AppRoute.transaction,arguments: {'supportedcoin':wc.supportedCoins!,"asset":asset});
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15.sp,),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[500],
                                    radius: 25.sp,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.ssid_chart,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async{
                                        Market? market=await Provider.of<CoinMarketController>(context,listen: false).getMarket(asset.coinGekoId!);
                                        if(market!=null){
                                          Navigator.pushNamed(context, AppRoute.coinInfo,arguments: market);
                                        }                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50.sp,),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: wc.supportedCoins!.map((e){
                              //     return ListTile(
                              //       onTap: (){
                              //         Navigator.pushNamed(context, AppRoute.transaction,arguments: {'supportedcoin':wc.supportedCoins!,"asset":e});
                              //       },
                              //       leading: SizedBox(
                              //           width: 20.sp,
                              //           height: 20.sp,
                              //           child: Image.asset(e.coinImage)
                              //       ),
                              //       title: MediumText(
                              //         text: e.asset_name,
                              //         color: w_text_color,
                              //         weight: FontWeight.w700,
                              //         align: TextAlign.start,
                              //         maxLines: 1,
                              //       ),
                              //       trailing: Icon(
                              //         Icons.arrow_forward_ios_rounded,
                              //         color: w_text_color,
                              //         size: 15.sp,
                              //       ),
                              //     );
                              //   }).toList(),
                              // )
                              SizedBox(
                                child:  ExpandedTileList.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: wc.supportedCoins!.length,
                                  maxOpened: 1,
                                  reverse: false,
                                  itemBuilder: (context, index, controller) {
                                    SupportedCoin asset=wc.supportedCoins![index];
                                    BalanceModel? balance=bc.balances[asset.asset_name];
                                    double coinBalance=0;
                                    double value=0;
                                    if(balance!=null){
                                      log(balance.totalBalance!.toString());
                                      log(bc.currentPrices[asset.asset_name]!.toStringAsFixed(2));
                                      coinBalance=balance.totalBalance!*bc.currentPrices[asset.asset_name]!;
                                      value=balance.totalBalance!/bc.currentPrices[asset.asset_name]!;
                                      // bc.totalBalance+=balance.totalBalance!;
                                    }
                                    log("${asset.asset_name}: ${value.toString()}");
                                    return ExpandedTile(
                                      theme: ExpandedTileThemeData(
                                        headerColor: themeController.isDark?primary_color_light:Colors.grey[300],
                                        headerRadius: 12.sp,
                                        headerPadding: EdgeInsets.all(8.sp),
                                        headerSplashColor: Colors.grey,
                                        contentBackgroundColor: themeController.isDark?primary_color_light:Colors.grey[300],
                                        contentRadius: 12.sp,
                                      ),
                                      controller: index == 2 ? controller.copyWith(isExpanded: true) : controller,
                                      trailingRotation: 0,
                                      leading: SizedBox(
                                        width: 30.sp,
                                        height: 30.sp,
                                        child: asset.coinType==CoinType.COIN?Image.asset(
                                          asset.coinImage,
                                          height: 30.sp,
                                          width: 30.sp,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context,v,_)=>Icon(
                                            Icons.error,
                                            size: getsmallIconSize(),
                                          ),
                                        ):CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor: Colors.grey,
                                          child: Padding(
                                              padding: EdgeInsets.all(2.0.sp),
                                              child: Text(
                                                asset.tokenType!,
                                                style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 5.sp
                                                ),
                                              )
                                          ),
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          MediumText(
                                            text: asset.asset_name,
                                            color: Colors.white,
                                            weight: FontWeight.normal,
                                            align: TextAlign.start,
                                            maxLines: 2,
                                          ),
                                          SizedBox(width: 4.sp,),
                                          asset.coinType==CoinType.COIN?const SizedBox():Chip(
                                              backgroundColor: themeController.isDark?Colors.grey[700]:Colors.white38,
                                              label: Text(
                                                asset.tokenChain!,
                                                style: TextStyle(
                                                    color: lb_text_color,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.normal
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                      trailing: balance!=null?SizedBox(
                                        width: width*0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3.sp),
                                              child: SmallText(
                                                text: asset.coinType==CoinType.COIN?CurrencyFormatter.format(coinBalance.toStringAsFixed(2), formatter):"${value.toStringAsFixed(2)} ${asset.tokenSymbol!.toUpperCase()}",
                                                color: themeController.isDark?w_text_color:b_text_color,
                                                weight: FontWeight.bold,
                                                align: TextAlign.end,
                                              ),
                                            ),
                                            coinBalance!=0?Padding(
                                              padding: EdgeInsets.all(3.sp),
                                              child: SmallText(
                                                text: asset.coinType==CoinType.COIN?value.toStringAsFixed(6):"${value.toStringAsFixed(2)} ${asset.tokenSymbol!.toUpperCase()}",
                                                color: themeController.isDark?w_text_color:b_text_color,
                                                weight: FontWeight.bold,
                                                align: TextAlign.end,
                                              ),
                                            ):SizedBox(),
                                          ],
                                        ),
                                      ):const SizedBox(),
                                      content: Container(
                                          width: width,
                                          color: themeController.isDark?primary_color_light:Colors.grey[300],
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MyButton(
                                                text: "Send",
                                                bgColor: Colors.amber,
                                                borderSideColor: Colors.amber,
                                                txtColor: lb_text_color,
                                                bgRadius: 20.sp,
                                                width: width*0.5,
                                                onPressed: (){
                                                  SupportedCoin sp=wc.supportedCoins![index];
                                                  if(sp.coinType==CoinType.COIN){
                                                    Navigator.pushNamed(context, AppRoute.sendPage,arguments: asset);
                                                  }else{
                                                    Navigator.pushNamed(context, AppRoute.sendToken,arguments: asset);

                                                  }
                                                },
                                                verticalPadding: 10.sp,
                                              ),
                                              const Spacer(),
                                              walletAction(Icons.call_received,(){
                                                Navigator.pushNamed(context, AppRoute.receivePage,arguments: asset);
                                              }),
                                              asset.coinType==CoinType.COIN?walletAction(Icons.bar_chart,()async{
                                                Market? market=await Provider.of<CoinMarketController>(context,listen: false).getMarket(asset.coinGekoId!);
                                                if(market!=null){
                                                  Navigator.pushNamed(context, AppRoute.coinInfo,arguments: market);
                                                }
                                              }): asset.tokenChainId!=null? walletAction(Icons.bar_chart,()async{
                                                Navigator.pushNamed(context, AppRoute.tokenInfo,arguments: asset);
                                              }):Container(
                                                margin: EdgeInsets.all(2.sp),
                                                padding: EdgeInsets.all(10.sp),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                                child: Icon(
                                                  Icons.bar_chart,
                                                  color: Colors.black,
                                                  size: getBigIconSize(),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      onTap: () {
                                        debugPrint("tapped!!");
                                      },
                                      onLongTap: () {
                                        debugPrint("looooooooooong tapped!!");
                                      },
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(height: 2.sp,);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    );
                  }
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget walletAction(IconData icons,Function onPressed){
    return GestureDetector(
      onTap: (){
        onPressed.call();
      },
      child: Container(
        margin: EdgeInsets.all(2.sp),
        padding: EdgeInsets.all(10.sp),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          icons,
          color: Colors.black,
          size: getBigIconSize(),
        ),
      ),
    );
  }
}
