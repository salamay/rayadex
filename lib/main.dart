import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/Apptheme.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Market/news/controller/news_controller.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/BalanceController.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/controller/home-controller.dart';
import 'package:ryipay/screens/new_wallet/controller/import_wallet_controller.dart';
import 'package:ryipay/screens/new_wallet/controller/new_wallet_controller.dart';
import 'package:ryipay/screens/settings/security_center/controller/security_controller.dart';
import 'package:tatum/tatum.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'screens/home/Market/coin_info/model/controller/coin_info_controller.dart';
import 'screens/settings/theme/controller/theme_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Tatum.initArchitecture();
  await Firebase.initializeApp();
  await GetStorage.init();
  TrustWalletCoreLib.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>NewWalletController()),
        ChangeNotifierProvider(create: (_)=>ImportWalletController()),
        ChangeNotifierProvider(create: (_)=>HomeController()),
        ChangeNotifierProvider(create: (_)=>CoinMarketController()),
        ChangeNotifierProvider(create: (_)=>CoinInfoController()),
        ChangeNotifierProvider(create: (_)=>NewsController()),
        ChangeNotifierProvider(create: (_)=>WalletController()),
        ChangeNotifierProvider(create: (_)=>BalanceController()),
        ChangeNotifierProvider(create: (_)=>ThemeController()),
        ChangeNotifierProvider(create: (_)=>SecurityController()),
        ChangeNotifierProvider(create: (_)=>TransactionController())
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return Consumer<ThemeController>(
              builder: (context,themeController,_) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeController.isDark?AppTheme.darkTheme:AppTheme.lightTheme,
                  initialRoute: AppRoute.splash,
                  onGenerateRoute: AppRoute.onGenerateRoute,
                );
              }
            );
          }
      ),
    );
  }
}

