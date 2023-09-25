import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/deep_link/DynamicLinkHandler.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/BalanceController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'Market/coin_markets/constants/market_period.dart';
import 'Market/coin_markets/models/chart_duration_model.dart';
import 'controller/home-controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late CoinMarketController coinMarketController;
  late BalanceController balanceController;
  late TransactionController transactionController;

  @override
  void initState() {
    // TODO: implement initState
    coinMarketController=Provider.of<CoinMarketController>(context,listen: false);
    balanceController=Provider.of<BalanceController>(context,listen: false);
    transactionController=Provider.of<TransactionController>(context,listen: false);
    setTup();
  }
  void setTup()async{
   try{
     await coinMarketController.getCoinMarkets();
     coinMarketController.changeChartPeriod(ChartPeriod(days: MarketPeriod.day_day, interval: MarketPeriod.hourly));
     balanceController.getBalances(context);
     transactionController.getTransaction(context);
     // DynamicLinkHandler().initDynamicLinks(context);
   }catch(e){
     log(e.toString());
   }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (context,homecontroller,child) {
          return Consumer<ThemeController>(
            builder: (context,themeController,_) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(
                  height: height,
                  width: width,
                 // child: homecontroller.dashboards[homecontroller.index],
                  child:  IndexedStack(
                  index: homecontroller.index,
                  children: homecontroller.dashboards,
                  )
                ),
                bottomNavigationBar: SizedBox(
                  width: width,
                  height: height*0.07,
                  child: GNav(
                      rippleColor: Colors.grey.withOpacity(0.7), // tab button ripple color when pressed
                      hoverColor: button_color, // tab button hover color
                      haptic: true, // haptic feedback
                      tabBorderRadius: 15.sp,
                      tabActiveBorder: Border.all(color: Colors.transparent, width: 1), // tab button border
                      tabBorder: Border.all(color: Colors.transparent, width: 1), // tab button border
                      curve: Curves.linear, // tab animation curves
                      duration:const Duration(milliseconds: 500), // tab animation duration
                      gap: 0, // the tab button gap between icon and text
                      color: primary_color_light, // unselected icon color
                      activeColor: button_color, // selected icon and text color
                      iconSize: getBigIconSize(), // tab button icon size
                      tabBackgroundColor: bottom_bar, // selected tab background color
                      padding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.01), //
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,// navigation bar padding
                      selectedIndex: homecontroller.index,
                      backgroundColor: themeController.isDark?bottom_bar:Colors.white,
                      onTabChange: (index){
                        print(index);
                        homecontroller.changeIndex(index);
                      },
                      tabs:  [
                        GButton(
                          icon: Icons.home_filled,
                          text: '',
                          backgroundColor: themeController.isDark?bottom_bar:Colors.grey[300],
                          textColor: w60_text_color,
                          iconColor: themeController.isDark?Colors.white70:Colors.black54,
                        ),
                        GButton(
                          icon: Icons.account_balance_wallet_outlined,
                          text: '',
                          backgroundColor: themeController.isDark?bottom_bar:Colors.grey[300],
                          textColor: w60_text_color,
                          iconColor: themeController.isDark?Colors.white70:Colors.black54,
                        ),
                        GButton(
                          icon: Icons.web_asset,
                          text: '',
                          backgroundColor: themeController.isDark?bottom_bar:Colors.grey[300],
                          textColor: w60_text_color,
                          iconColor: themeController.isDark?Colors.white70:Colors.black54,
                        ),
                        GButton(
                          icon: Icons.settings,
                          text: '',
                          backgroundColor: themeController.isDark?bottom_bar:Colors.grey[300],
                          textColor: themeController.isDark?w60_text_color:Colors.black54,
                          iconColor: themeController.isDark?Colors.white70:Colors.black54,
                        )
                      ]
                  ),
                ),
              );
            }
          );
        }
    );
  }
}
