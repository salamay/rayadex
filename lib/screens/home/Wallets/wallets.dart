
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/LargeText.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/BalanceController.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:ryipay/screens/widget/loading.dart';

import 'model/balance_model/xrp_balance.dart';
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
                              bc.balances[asset!.wallet_address]!=null?LargeText(
                                text: "XRP ${bc.balances[asset.wallet_address]!.balance}",
                                color: w_text_color,
                                weight: FontWeight.bold,
                                align: TextAlign.start,
                                maxLines: 1,
                              ):Loading(),
                              SizedBox(height: 10.sp,),
                              bc.balances[asset.wallet_address]!=null&&bc.currentPrices[asset.asset_name]!=null?MediumText(
                                text: CurrencyFormatter.format(bc.currentPrices[asset.asset_name]!*double.parse(bc.balances[asset.wallet_address]!.balance), dollarConverter),
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
                              SizedBox(height: 40.sp,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: MediumText(
                                  text: "Transactions",
                                  color: w_text_color,
                                  weight: FontWeight.w300,
                                  align: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: wc.supportedCoins!.map((e){
                                  return ListTile(
                                    onTap: (){
                                      Navigator.pushNamed(context, AppRoute.transaction,arguments: {'supportedcoin':wc.supportedCoins!,"asset":e});
                                    },
                                    leading: SizedBox(
                                        width: 20.sp,
                                        height: 20.sp,
                                        child: Image.asset(e.coinImage)
                                    ),
                                    title: MediumText(
                                      text: e.asset_name,
                                      color: w_text_color,
                                      weight: FontWeight.w700,
                                      align: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: w_text_color,
                                      size: 15.sp,
                                    ),
                                  );
                                }).toList(),
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
