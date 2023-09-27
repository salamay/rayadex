import 'dart:convert';
import 'dart:typed_data';
import 'package:base_x/base_x.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart' as mn;
import 'package:crypto/crypto.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
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
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:hex/hex.dart';
import 'package:uuid/uuid.dart';
import 'package:web3dart/credentials.dart';
import 'package:convert/convert.dart';
import 'package:xrp_dart/xrp_dart.dart' as xrpDart;
import '../wif.dart';


class NewWalletController extends ChangeNotifier{
  bool isPassPhrase=false;
  String? mnemonic;
  String passphrase="";
  final localDatabase=LocalDatabase();
  HDWallet? wallet;
  var uuid = Uuid();


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
    try{
      log(mnemonics);
      wallet = HDWallet.createWithMnemonic(mnemonics);
      await Future.wait(Global.coins.map((cm)async{
        String coinType=cm.wallet_BIP44path!.split("/")[2].replaceAll("'", "");
        log("CoinType $coinType");
        String? walletAddress;
        PrivateKey? pky;
        walletAddress=wallet!.getAddressForCoin(int.parse(coinType));
        pky= wallet!.getKeyForCoin(int.parse(coinType));
        String privateKey;

        if(coinType=="0"||coinType=="3"){
          final wif = WIF.encode(hex.encode(pky.data()),int.parse(coinType));
          privateKey=wif;
        }else if(coinType=="144"){
          pky= wallet!.getKeyForCoin(TWCoinType.TWCoinTypeXRP);
          walletAddress=wallet!.getAddressForCoin(TWCoinType.TWCoinTypeXRP);
          privateKey=hex.encode(pky.data());
        }else{
          privateKey =hex.encode(pky.data());
        }
        final supportedCoin=SupportedCoin(
          id: uuid.v1(),
          wallet_id: walletModel.wallet_id,
          asset_name: cm.asset_name,
          wallet_BIP44path: cm.wallet_BIP44path,
          address_index: cm.wallet_BIP44path!.split('/').last,
          coinImage: cm.coinImage,
          coinGekoId: cm.coinGekoId,
          coinType: cm.coinType,
          wallet_address:walletAddress,
          privateKey: privateKey,
        );
        await localDatabase.saveCoin(supportedCoin);
      }).toList());
    }catch(e){
      log(e.toString());
      ShowSnackBar.show(context, "oops, something went wrong, please check your mnemonic phrase", Colors.red);
      throw Exception("");
    }
  }

  String convertToXRPPrivateKeyFormat(List<int> privateKeyBytes) {
    // Perform SHA-256 hashing twice
    List<int> hash = sha256.convert(privateKeyBytes).bytes;
    hash = sha256.convert(hash).bytes;

    // Take the first 4 bytes as the checksum
    List<int> checksum = hash.sublist(0, 4);

    // Append the checksum to the private key
    List<int> privateKeyWithChecksum = [...privateKeyBytes, ...checksum];

    // Encode in Base58Check
    var base58 = BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

    var value = privateKeyWithChecksum;
    String base58PrivateKey = base58.encode(Uint8List.fromList(value));

    // Trim to the first 31 characters (keeping space for 's')
    String trimmedKey = base58PrivateKey.substring(0, 30);

    // Ensure the private key starts with 's'
    if (trimmedKey.startsWith('s')) {
      return trimmedKey;
    } else {
      // If not, append 's' and return
      return 's$trimmedKey'.substring(0, 31);
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