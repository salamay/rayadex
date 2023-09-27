import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Transactions/model/transaction.dart';
import 'package:ryipay/screens/home/Transactions/model/xrp_transaction.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:xrp_dart/src/crypto/keypair/xrpl_private_key.dart';
import 'package:xrp_dart/xrp_dart.dart';
import 'package:xrp_dart/src/xrpl/helper.dart';
import 'package:xrp_dart/src/xrpl/models/currencies/currencies.dart';
import 'package:xrp_dart/src/xrpl/models/payment/payment.dart';
import 'package:xrp_dart/src/rpc/rpc_service.dart' as xrpRpc;


class TransactionController extends ChangeNotifier {
  final my_api = MyApi();
  Map<String,List<TransactionModel>> transactions={};



  void populateAsset({required List<SupportedCoin> supportedCoin}){
    log(supportedCoin.length.toString());
    supportedCoin.map((e){
      log(e.wallet_address!);
      transactions[e.wallet_address!]=[];
    }).toList();
  }


  Future<void> getTransaction(BuildContext context)async{
    log("Getting wallet transactions");
    var wc=Provider.of<WalletController>(context,listen: false);
    await Future.wait(Provider.of<WalletController>(context,listen: false).supportedCoins!.map((e)async{
      try{

        if(e.coinType==CoinType.COIN){
          // await getCurrentPrice(context, "usd");
          if(e.asset_name==CoinName.XRP.name){
            await _getTransactions(context, e.wallet_address!);
          }else{
            throw Exception("UnKnown");
          }
        }else{

        }

      }catch(e){
        log(e.toString());
      }
    }).toList());
  }


  Future<void> sendCoin({required BuildContext context, required CoinType coinType, required String coinName, required String from, required String to, required String privateKey, required double amount}) async {
    try {
      if (coinType == CoinType.COIN) {
        if (coinName == CoinName.XRP.name) {
          await _sendXrp(context, from, to, privateKey, amount);
        } else if (coinName == CoinName.Bitcoin.name) {
          await _sendBitcoin(context, from, to, privateKey, amount);
        } else if (coinName == CoinName.Ethereum.name) {
          await _sendEthereum(context, from, to, privateKey, amount);
        } else if (coinName == CoinName.Doge.name) {
          await _sendDoge(context, from, to, privateKey, amount);
        } else {
          throw Exception("UnKnown");
        }
      } else {
        throw Exception("Not implemented yet");
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<void> _sendXrp(context, String from, String to, String privateKey, double amount) async {
    try {
      log("Sending XRP");
      final private = XRPPrivateKey.fromHex("00$privateKey");
      final String ownerAddress = private.getPublic().toAddress().address;
      final String ownerPublic = private.getPublic().toHex();
      print("owner public: $ownerPublic");
      final transaction = Payment(
          destination: to,
          account: ownerAddress,
          amount: CurrencyAmount.xrp(BigInt.from(amount*1000000)),
          signingPubKey: ownerPublic
      );
      XRPLRpc rpc=XRPLRpc(xrpRpc.JsonRPC(MyApi.getBlockXrpRpc,Client()));
      print("autofill transaction");
      await autoFill(rpc, transaction);
      final blob = transaction.toBlob();
      print("sign transaction");
      final sig = private.sign(blob);
      print("Set transaction signature");
      transaction.setSignature(sig);
      final trhash = transaction.getHash();
      print("transaction hash: $trhash");
      final trBlob = transaction.toBlob(forSigning: false);
      print("regenarate transaction blob with exists signatures");

      print("broadcasting signed transaction blob");
      final result = await rpc.submit(trBlob);
      print("transaction hash: ${result.txJson.hash}");
      print("engine result: ${result.engineResult}");
      print("engine result message: ${result.engineResultMessage}");
      print("is success: ${result.isSuccess}");
      ShowSnackBar.show(context, result.engineResultMessage, Colors.green);
      // var body = {
      //   "fromAccount": from,
      //   "amount": amount.toString(),
      //   "fromSecret": privateKey,
      //   "to": to
      // };
      // var response = await my_api.post(jsonEncode(body), ApiUrls.sendXrp, {"Content-Type": "application/json", 'x-api-key': MyApi.tatumApiKey});
      // log(response!.body);
      // if (response.statusCode == 200) {
      //   log(response.statusCode.toString());
      //   String txId = jsonDecode(response.body)['txId'];
      //   log(txId);
      //   ShowSnackBar.show(context, "Successful", Colors.green);
      //   Navigator.pop(context);
      // } else {
      //   String cause = jsonDecode(response.body)['cause'];
      //   ShowSnackBar.show(context, cause, Colors.red);
      // }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to send xrp", Colors.red);
    }
  }


  Future<void> _sendBitcoin(context, String from, String to, String privateKey, double amount) async {
    try {
      log("Sending Bitcoin");
      var body = {
        "fromAddress": [
          {
            "address": from,
            "privateKey": privateKey
          }
        ],
        "to": [
          {
            "address": to,
            "value": amount //btc
          }
        ]
      };
      var response = await my_api.post(jsonEncode(body), ApiUrls.sendBitcoin,
          {"Content-Type": "application/json", 'x-api-key': MyApi.tatumApiKey});
      log(response!.body);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        String txId = jsonDecode(response.body)['txId'];
        log(txId);
        ShowSnackBar.show(context, "Successful", Colors.green);
        Navigator.pop(context);
      } else {
        String message = jsonDecode(response.body)['message'];
        ShowSnackBar.show(context, message, Colors.red);
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to send bitcoin", Colors.red);
      throw Exception(e.toString());
    }
  }


  Future<void> _sendDoge(context, String from, String to, String privateKey,
      double amount) async {
    try {
      log("Sending Doge coin");
      var body = {
        "fromAddress": [
          {
            "address": from,
            "privateKey": privateKey
          }
        ],
        "to": [
          {
            "address": to,
            "value": amount //doge
          }
        ]
      };
      var response = await my_api.post(jsonEncode(body), ApiUrls.sendDoge,
          {"Content-Type": "application/json", 'x-api-key': MyApi.tatumApiKey});
      log(response!.body);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        String txId = jsonDecode(response.body)['txId'];
        log(txId);
        ShowSnackBar.show(context, "Successful", Colors.green);
        Navigator.pop(context);
      } else {
        String message = jsonDecode(response.body)['message'];
        ShowSnackBar.show(context, message, Colors.red);
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to send Doge", Colors.red);
      throw Exception(e.toString());
    }
  }

  Future<void> _sendEthereum(context, String from, String to, String privateKey,
      double amount) async {
    try {
      log("Sending Eth");
      var body = {
        "to": to,
        "amount": amount.toStringAsFixed(5),
        "currency": "ETH",
        "fromPrivateKey": privateKey
      };
      var response = await my_api.post(jsonEncode(body), ApiUrls.sendEthereum,
          {"Content-Type": "application/json", 'x-api-key': MyApi.tatumApiKey});
      log(response!.body);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        String txId = jsonDecode(response.body)['txId'];
        log(txId);
        ShowSnackBar.show(context, "Successful", Colors.green);
        Navigator.pop(context);
      } else {
        String message = jsonDecode(response.body)['message'];
        ShowSnackBar.show(context, message, Colors.red);
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to send ETH", Colors.red);
      throw Exception(e.toString());
    }
  }

  Future<void> _getTransactions(context, String walletAddress) async {
    log("Getting transaction");
    try {
      var response = await my_api.get("${ApiUrls.xrpTx}/$walletAddress", {"Content-Type": "application/json",'x-api-key':MyApi.tatumApiKey});
      if (response!.statusCode == 200) {
        final xrpTx = xrpTransactionsFromJson(response.body);
        log(response.body.toString());
        List<TransactionModel> txModel=xrpTx.transactions.map((e) {
          int drop=1000000;
          double xrpValue=double.parse(e.tx.amount!)/drop;
          e.tx.amount=xrpValue.toString();
          return TransactionModel(
              txHash: e.tx.hash!,
              timesTamp: e.tx.date!,
              from: e.tx.account!,
              to: e.tx.destination!,
              amount: e.tx.amount!
          );
        }).toList();
        transactions[walletAddress]=txModel;
        notifyListeners();
      } else {
        ShowSnackBar.show(context, "Unable to get transactions",Colors.red);
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to get transactions",Colors.red);
    }
  }
}