import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_db.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/home/Wallets/model/wallet_model.dart';

class WalletController extends ChangeNotifier{
  final _localDatabase=LocalDatabase();
  List<WalletModel>? wallets;
  List<SupportedCoin>? supportedCoins;
  WalletModel? currentWallet;

  Future<List<WalletModel>?> getAllUserWallet(context)async{
    try{
      wallets=await _localDatabase.getAllWallet();
      if(wallets!=null&&wallets!.isNotEmpty){
        currentWallet=wallets!.first;
        await getSupportedCoin(context);
        Provider.of<TransactionController>(context,listen: false).populateAsset(supportedCoin: supportedCoins!);
        return wallets;
      }else{
        return [];
      }

    }catch(e){
      log(e.toString());
      throw Exception();
    }
  }
  Future<List<SupportedCoin>?> getSupportedCoin(context)async{
    try{
      supportedCoins=await _localDatabase.getSupportedCoin(currentWallet!.wallet_id);
      notifyListeners();
      return supportedCoins;
    }catch(e){
      log(e.toString());
      throw Exception();
    }
  }


  Future<void> changeWallet(WalletModel walletModel)async{
    currentWallet=walletModel;
    supportedCoins=await _localDatabase.getSupportedCoin(currentWallet!.wallet_id);
    notifyListeners();
  }

  SupportedCoin? getAssets(String assetName){
    if(supportedCoins!=null&&supportedCoins!.isNotEmpty){
      return supportedCoins!.where((element) => element.asset_name==assetName).first;
    }else{
      return null;
    }
  }
  void refresh(){
    notifyListeners();
  }
}