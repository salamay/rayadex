import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/screens/home/Market/coin_markets/see_all_topgainers.dart';
import 'package:ryipay/screens/home/Market/coin_markets/see_all_toploosers.dart';
import 'package:ryipay/screens/home/Market/token_info/token_info.dart';
import 'package:ryipay/screens/home/Transactions/AllTransaction.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/home/Wallets/send_and_receive/send_coin.dart';
import 'package:ryipay/screens/home/home_page.dart';
import 'package:ryipay/screens/home/web3_browser/browser.dart';
import 'package:ryipay/screens/new_wallet/import_wallet.dart';
import 'package:ryipay/screens/new_wallet/new_wallet.dart';
import 'package:ryipay/screens/settings/about/AboutApp.dart';
import 'package:ryipay/screens/settings/base_currency/base_curency.dart';
import 'package:ryipay/screens/settings/launch_screen/launch_screen.dart';
import 'package:ryipay/screens/settings/manage_wallet/backup/backup_phrase.dart';
import 'package:ryipay/screens/settings/manage_wallet/change_wallet.dart';
import 'package:ryipay/screens/settings/manage_wallet/manage_wallet.dart';
import 'package:ryipay/screens/settings/security_center/app_security.dart';
import 'package:ryipay/screens/settings/security_center/set_pin.dart';
import 'package:ryipay/screens/settings/theme/theme.dart';
import 'package:ryipay/screens/settings/widget/webview.dart';
import 'package:ryipay/screens/splash/splash_screen.dart';
import 'package:ryipay/screens/wallet_action/wallet_action.dart';
import '../screens/home/Market/coin_info/coin_info.dart';
import '../screens/home/Wallets/send_and_receive/receive_coin.dart';

class AppRoute{
  static const splash="splashScreen";
  static const walletAction="walletAction";
  static const newWallet="newWallet";
  static const importWallet="importWallet";
  static const importByPrivateKey="importByPrivateKey";
  static const homepage="homepage";
  static const manageWallets="manageWallets";
  static const launchScreen="launchScreen";
  static const baseCurrency="baseCurrency";
  static const theme="theme";
  static const coinInfo="coinInfo";
  static const allTopGainers="allTopGainers";
  static const allTopLoosers="allTopLoosers";
  static const sendPage="sendPage";
  static const receivePage="receivePage";
  static const transaction="transaction";
  static const buyPage="buyPage";
  static const addToken="addToken";
  static const sendToken="sendToken";
  static const backup="backup";
  static const aboutApp="aboutApp";
  static const webView="webView";
  static const setPin="setPin";
  static const appSecurity="appSecurity";
  static const walletConnectScanner="WalletConnectScanner";
  static const walletConnectScreen="WalletConnectScreen";
  static const browser="browser";
  static const tokenInfo="tokenInfo";
  static const changeWallet="changeWallet";


  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case splash:
        return MaterialPageRoute(
            builder: (_)=> SplashScreen()
        );
      case walletAction:
        return MaterialPageRoute(
            builder: (_)=> WalletAction()
        );
        case newWallet:
          return MaterialPageRoute(
            builder: (_)=> NewWallet()
        );
          case importWallet:
          return MaterialPageRoute(
            builder: (_)=> ImportWallet()
        );
          case homepage:
          return MaterialPageRoute(
            builder: (_)=> HomePage()
        );
          case manageWallets:
          return MaterialPageRoute(
            builder: (_)=> ManageWallet()
        );
          case launchScreen:
          return MaterialPageRoute(
            builder: (_)=> LaunchScreen()
        );
          case baseCurrency:
          return MaterialPageRoute(
            builder: (_)=> BaseCurrency()
        );
          case theme:
          return MaterialPageRoute(
            builder: (_)=> MyTheme()
        );
          case coinInfo:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> CoinInfo(market: args as Market,)
        );
          case allTopGainers:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> TopGainers(topGainers: args as List<Market>,)
        );
          case allTopLoosers:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> TopLoosers(topLoosers: args as List<Market>,)
        );
          case sendPage:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> SendCoin(coin: args as SupportedCoin,)
        );
          case receivePage:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> ReceiveCoin(coin: args as SupportedCoin,)
        );
          case backup:
          return MaterialPageRoute(
            builder: (_)=> BackupPhrase()
        );
          case aboutApp:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> const AboutApp()
        );
          case webView:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> WebView(url: args as String,)
        );
      case browser:
        final args=settings.arguments as Map;
        String urlString = args["url"];
        bool save = args["save"];
        return MaterialPageRoute(
            builder: (_)=> Browser(save: save,urlString: urlString,)
        );
          case setPin:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> SetPin()
        );
          case appSecurity:
            final args=settings.arguments;
          return MaterialPageRoute(
            builder: (_)=> const AppSecurity()
        );
          case tokenInfo:
            final args=settings.arguments as SupportedCoin;
          return MaterialPageRoute(
            builder: (_)=> TokenInfo(asset:args,)
        );
          case changeWallet:
          return MaterialPageRoute(
            builder: (_)=> ChangeWallet()
        );
          case transaction:
            final args=settings.arguments as Map;
            return MaterialPageRoute(
            builder: (_)=>AllTransaction(asset: args['asset'],),
        );
      default:
        throw UnimplementedError("no route exists for ${settings.name}");
    }
  }
}