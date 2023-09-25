import 'package:flutter/cupertino.dart';
import 'package:ryipay/screens/home/Market/markets.dart';
import 'package:ryipay/screens/home/Wallets/wallets.dart';
import 'package:ryipay/screens/home/web3_browser/dapp_browser.dart';
import 'package:ryipay/screens/settings/settings.dart';

class HomeController extends ChangeNotifier{

  List<Widget> dashboards=[
    MarketPage(),
    Wallets(),
    DAppBrowser(),
    // WebView(url: "https://alphawallet.com/browser/"),
    Settings(),
  ];
  int index=0;
  void changeIndex(int index){
    this.index=index;
    notifyListeners();
  }
}