import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/AppEnum.dart';
import 'package:ryipay/screens/home/Transactions/model/transaction.dart';
import 'package:ryipay/screens/home/Transactions/model/xrp_transaction.dart';
import 'package:ryipay/screens/home/Wallets/controller/wallet_controller.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';

class TransactionController extends ChangeNotifier {
  final my_api = MyApi();
  Map<String,List<TransactionModel>> transactions={};



  void populateAsset({required List<SupportedCoin> supportedCoin}){
    supportedCoin.map((e){
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
  Future<void> _sendXrp(context, String from, String to, String privateKey,
      double amount) async {
    try {
      log("Sending XRP");
      var body = {
        "fromAccount": from,
        "amount": amount.toString(),
        "fromSecret": privateKey,
        "to": to
      };
      var response = await my_api.post(jsonEncode(body), ApiUrls.sendXrp, {"Content-Type": "application/json", 'x-api-key': MyApi.tatumApiKey});
      log(response!.body);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        String txId = jsonDecode(response.body)['txId'];
        log(txId);
        ShowSnackBar.show(context, "Successful", Colors.green);
        Navigator.pop(context);
      } else {
        String cause = jsonDecode(response.body)['cause'];
        ShowSnackBar.show(context, cause, Colors.red);
      }
    } catch (e) {
      log(e.toString());
      ShowSnackBar.show(context, "Unable to send bitcoin", Colors.red);
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