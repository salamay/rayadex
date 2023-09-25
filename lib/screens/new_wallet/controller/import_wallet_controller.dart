import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_db.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/global/global.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/home/Wallets/model/wallet_model.dart';
import 'package:ryipay/screens/new_wallet/controller/new_wallet_controller.dart';
import 'package:uuid/uuid.dart';

import '../../home/Wallets/controller/wallet_controller.dart';
class ImportWalletController extends ChangeNotifier{
  final localDatabase=LocalDatabase();
  var uuid = Uuid();
  Future<void> importFromMnemonics(String mnemonic,BuildContext context)async{
    try{
      var wlc=Provider.of<WalletController>(context,listen: false);
      var walletController=Provider.of<NewWalletController>(context,listen: false);
      List<WalletModel>? wallets=await wlc.getAllUserWallet(context);
      final walletModel=WalletModel(wallet_id: uuid.v1().toString(),wallet_name: "Wallet ${wallets!.length.toString()}",mnemonic: mnemonic,walletType: WalletType.MULTI.name);
      await walletController.generateCoin(context:context,mnemonics: mnemonic, walletModel: walletModel);
      await localDatabase.saveWallet(walletModel);
      await wlc.changeWallet(walletModel);
      await wlc.getAllUserWallet(context);
    }catch(e){
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> importFromPrivateKey(String privateKey,BuildContext context)async{
    try{
      var wlc=Provider.of<WalletController>(context,listen: false);
      var walletController=Provider.of<NewWalletController>(context,listen: false);
      List<WalletModel>? wallets=await wlc.getAllUserWallet(context);
      final walletModel=WalletModel(wallet_id: uuid.v1().toString(),wallet_name: "Wallet ${wallets!.length.toString()}",privateKey: privateKey,walletType: WalletType.SINGLE.name);
      //Ethereum
      SupportedCoin asset=Global.coins[1];
      await walletController.generateAssetByPrivateKey(context:context,privateKey: privateKey, walletModel: walletModel, chain: TokenBlockChain.Ethereum,asset: asset);
      await localDatabase.saveWallet(walletModel);
      await wlc.changeWallet(walletModel);
      await wlc.getAllUserWallet(context);
    }catch(e){
      log(e.toString());
      throw Exception();
    }
  }

}