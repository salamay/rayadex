import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/coin_prices.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';

import '../../../../api/my_api.dart';
import '../model/balance_model/xrp_balance.dart';

class BalanceController extends ChangeNotifier{

  final my_api=MyApi();
  int defaultBalance=10;
  Map<String,XrpBalance> balances={};
  Map<String,double> currentPrices={};

  Future<XrpBalance?> getBalances(BuildContext context)async{
    log("Getting wallet balances");
    await getCurrentPrice(context, "usd");
    var wc=Provider.of<WalletController>(context,listen: false);
    XrpBalance? xrpBalance;
    await Future.wait(Provider.of<WalletController>(context,listen: false).supportedCoins!.map((e)async{
      try{

        if(e.coinType==CoinType.COIN){
            // await getCurrentPrice(context, "usd");
          if(e.asset_name==CoinName.XRP.name){
            xrpBalance= await _getXrpBalance(context, e.wallet_address!);
          }else{
            throw Exception("UnKnown");
          }
        }else{

        }

      }catch(e){
        log(e.toString());
      }
    }).toList());

    return xrpBalance;
  }


  Future<XrpBalance?> _getXrpBalance(context, String walletAddress) async {
    log("Getting xrp balance");
    try {
      var response = await my_api.get("${ApiUrls.xrpBalance}/$walletAddress/balance", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      log(response!.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body.toString());
        final xrpBalance = xrpBalanceFromJson(response.body);
        double drop=1000000;
        double xrpValue=(double.parse(xrpBalance.balance)/drop)-defaultBalance;
        xrpBalance.balance=xrpValue.toStringAsFixed(5);
        balances[walletAddress]=xrpBalance;
        notifyListeners();
        return xrpBalance;
      }else if(response.statusCode==403){
        balances[walletAddress]=XrpBalance(assets: [], balance: "0");
        notifyListeners();
      } else {
        ShowSnackBar.show(context, "Unable to get balance",Colors.red);
        return null;
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get balance",Colors.red);
      return null;
    }
  }


  Future<void> getCurrentPrice(context,String currency) async {
    log("Getting coin current prices");
    String coinIds='';
    String ids='';
    Provider.of<WalletController>(context,listen: false).supportedCoins!.map((e)async {
      coinIds="$coinIds${e.coinGekoId},";
      ids=coinIds.replaceAll(",", "%2C");
    }).toList();
      try {
      var response = await my_api.get("${ApiUrls.curentPrice}?ids=$ids&vs_currencies=$currency", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      if (response!.statusCode == 200) {
        log(response.statusCode.toString());
        log(response.body);
        final currentPr = currentPricesFromJson(response.body);
        Provider.of<WalletController>(context,listen: false).supportedCoins!.map((e)async{
          if(e.asset_name==CoinName.XRP.name){
            currentPrices[e.asset_name]=currentPr.ripple.usd;
            notifyListeners();
          }else{
            log("Current price--> Not implemented yet");
          }
        }).toList();
      } else {
        throw Exception("Unable to get current price ${response.statusCode.toString()}");
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get current price",Colors.red);
      throw Exception(e.toString());
    }
  }
}