import 'dart:convert';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as mn;
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:ryipay/LocalDatabase/local_db.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/global/global.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/home/Wallets/model/wallet_model.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';
import 'package:tatum/tatum.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:hex/hex.dart';
import 'package:uuid/uuid.dart';
import 'package:web3dart/credentials.dart';
import 'package:convert/convert.dart';
import '../wif.dart';
import 'package:dart_bs58check/dart_bs58check.dart' as bs58check;
import 'package:pointycastle/api.dart' as pc_api;
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/src/utils.dart' as pc_utils;
class NewWalletController extends ChangeNotifier{
  bool isPassPhrase=false;
  String? mnemonic;
  String passphrase="";
  final localDatabase=LocalDatabase();
  HDWallet? wallet;
  var uuid = Uuid();
  final tatum = Tatum.v3;


  void changePassPhrase(bool val){
    isPassPhrase=val;
    notifyListeners();
  }


  Future<String> generateMnemonic({String? passphrase,required int strength})async{
    try{
      mn.Mnemonic mnemonic;
      if(passphrase!=null){
        log(passphrase);
        mnemonic = mn.Mnemonic.generate(
          mn.Language.english,
          passphrase: passphrase,
          entropyLength: strength,
        );
      }else{
        mnemonic = mn.Mnemonic.generate(
          mn.Language.english,
          entropyLength: strength,
        );
      }
      return mnemonic.sentence;
    }catch(e){
      log(e.toString());
      throw Exception("");
    }
  }


  Future<void> createWallet({String? passphrase,required BuildContext context,required int strength})async{
    try{
      var wlc=Provider.of<WalletController>(context,listen: false);
      List<WalletModel>? wallets=await wlc.getAllUserWallet(context);
      String mnemonic=await generateMnemonic(passphrase: passphrase,strength: strength);
      final walletModel=WalletModel(wallet_id: uuid.v1(),wallet_name: "Wallet ${wallets!.length.toString()}",mnemonic: mnemonic,walletType: WalletType.MULTI.name);
      await localDatabase.saveWallet(walletModel);
      await generateCoin(context:context,mnemonics: mnemonic, walletModel: walletModel);
      await wlc.changeWallet(walletModel);
      await wlc.getAllUserWallet(context);

    }catch(e){
      log(e.toString());
      throw Exception("");
    }
  }


  Future<void> generateCoin({required BuildContext context,required String mnemonics,required WalletModel walletModel})async{
    tatum.setKey('a85f8f21-ad23-4c31-9730-c329253ff059_100');
    try{
      log(mnemonics);
      wallet = HDWallet.createWithMnemonic(mnemonics);
      await Future.wait(Global.coins.map((cm)async{
        String coinType=cm.wallet_BIP44path!.split("/")[2].replaceAll("'", "");
        log("CoinType $coinType");
        final xrp = tatum.ripple;
        final wallet = await xrp.generateAccount();

        final supportedCoin=SupportedCoin(
          id: uuid.v1(),
          wallet_id: walletModel.wallet_id,
          asset_name: cm.asset_name,
          wallet_BIP44path: cm.wallet_BIP44path,
          address_index: cm.wallet_BIP44path!.split('/').last,
          coinImage: cm.coinImage,
          coinGekoId: cm.coinGekoId,
          coinType: cm.coinType,
          wallet_address:wallet.address!,
          privateKey: wallet.secret!,
        );
        await localDatabase.saveCoin(supportedCoin);
      }).toList());
    }catch(e){
      log(e.toString());
      ShowSnackBar.show(context, "oops, something went wrong, please check your mnemonic phrase", Colors.red);
      throw Exception("");
    }
  }

  Future<void> generateAssetByPrivateKey({required BuildContext context,required String privateKey,required WalletModel walletModel,required TokenBlockChain chain,required SupportedCoin asset})async{
    try{

      Credentials credentials = EthPrivateKey.fromHex(privateKey);
      EthereumAddress address = await credentials.extractAddress();
      String walletAddress=address.hex;
      asset.coinType=CoinType.TOKEN;
      asset.privateKey=privateKey;
      asset.tokenChain=chain.name;
      asset.wallet_address=walletAddress;
      asset.coinImage='';
      log(walletAddress);
    }catch(e){
      log(e.toString());
      ShowSnackBar.show(context, "oops, something went wrong, please check your private key", Colors.red);
      throw Exception("");
    }
  }

}