import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/balance_model/balance_model.dart';
import 'package:ryipay/screens/home/Wallets/model/coin_prices.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';

import '../../../../api/my_api.dart';
import '../model/balance_model/xrp_balance.dart';

class BalanceController extends ChangeNotifier{

  final my_api=MyApi();
  int defaultBalance=10;
  Map<String,BalanceModel> balances={};
  Map<String,double> currentPrices={};

  Future<BalanceModel?> getBalances(BuildContext context)async{
    log("Getting wallet balances");
    await getCurrentPrice(context, "usd");
    var wc=Provider.of<WalletController>(context,listen: false);
    BalanceModel? balanceModel;
    await Future.wait(Provider.of<WalletController>(context,listen: false).supportedCoins!.map((e)async{
      try{

        if(e.coinType==CoinType.COIN){
            // await getCurrentPrice(context, "usd");
          if(e.asset_name==CoinName.XRP.name){
            balanceModel= await _getXrpBalance(context, e.wallet_address!,e.asset_name);
          }else if(e.asset_name==CoinName.Bitcoin.name){
            balanceModel= await _getBitcoinBalance(context, e.wallet_address!,e.asset_name);
          }else if(e.asset_name==CoinName.Ethereum.name){
            balanceModel= await _getEthBalance(context, e.wallet_address!,e.asset_name);
          }else if(e.asset_name==CoinName.Doge.name){
            balanceModel= await _getDogeBalance(context, e.wallet_address!,e.asset_name);
          }else{
            throw Exception("UnKnown");
          }
        }else{

        }
        notifyListeners();
        return balanceModel;
      }catch(e){
        log(e.toString());
      }
    }).toList());
  }


  Future<BalanceModel?> _getXrpBalance(context, String walletAddress,String assetName) async {
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
        BalanceModel balanceModel=BalanceModel();
        balanceModel.totalBalance=double.parse(xrpBalance.balance);
        balances[assetName]=balanceModel;
        notifyListeners();
        return balanceModel;
      }else if(response.statusCode==403){
        BalanceModel balanceModel=BalanceModel();
        balanceModel.totalBalance=0;
        balances[assetName]=balanceModel;
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
  Future<BalanceModel> _getBitcoinBalance(context, String walletAddress,String assetName) async {
    log("Getting bitcoin balance");
    try {
      var response = await my_api.get("${ApiUrls.bitcoinBalance}/$walletAddress", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      if (response!.statusCode == 200) {
        log(response.statusCode.toString());
        final balanceModel = balanceModelFromJson(response.body);
        balanceModel.totalBalance=double.parse(balanceModel.incoming!)-double.parse(balanceModel.outgoing!);
        balances[assetName]=balanceModel;
        return balanceModel;
      } else {
        throw Exception("Unable to get bitcoin balance ${response.statusCode.toString()}");
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get balance",Colors.red);
      throw Exception(e.toString());
    }
  }

  Future<BalanceModel> _getEthBalance(context, String walletAddress,String assetName) async {
    log("Getting eth balance");
    try {
      var response = await my_api.get("${ApiUrls.ethBalance}/$walletAddress", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      if (response!.statusCode == 200) {
        log(response.statusCode.toString());
        final balanceModel = balanceModelFromJson(response.body);
        balanceModel.totalBalance=double.parse(jsonDecode(response.body)['balance']);
        balances[assetName]=balanceModel;
        return balanceModel;
      } else {
        throw Exception("Unable to get eth balance ${response.statusCode.toString()}");
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get balance",Colors.red);
      throw Exception(e.toString());
    }
  }

  Future<BalanceModel> _getDogeBalance(context, String walletAddress,String assetName) async {
    try {
      log("Getting doge balance");
      var response = await my_api.get("${ApiUrls.dogeBalance}/$walletAddress", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      if (response!.statusCode == 200) {
        log(response.statusCode.toString());
        final balanceModel = balanceModelFromJson(response.body);
        balanceModel.totalBalance=double.parse(balanceModel.incoming!)-double.parse(balanceModel.outgoing!);
        balances[assetName]=balanceModel;
        return balanceModel;
      } else {
        throw Exception("Unable to get doge balance ${response.statusCode.toString()}");
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get balance",Colors.red);
      throw Exception(e.toString());
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
          }else if(e.asset_name==CoinName.Bitcoin.name){
            currentPrices[e.asset_name]=currentPr.bitcoin.usd;
          }else if(e.asset_name==CoinName.Ethereum.name){
            currentPrices[e.asset_name]=currentPr.ethereum.usd;
          }else if(e.asset_name==CoinName.Doge.name){
            currentPrices[e.asset_name]=currentPr.dogecoin.usd;
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