import 'dart:convert';
import 'dart:developer';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/screens/home/Market/coin_markets/constants/market_period.dart';
import 'package:ryipay/screens/home/Market/coin_markets/models/chart_duration_model.dart';

import '../../../../../api/url/Api_url.dart';

class CoinMarketController extends ChangeNotifier{

  final my_api=MyApi();
  final _coinGeckoApi = CoinGeckoApi();
  List<Market> markets=[];
  ChartPeriod? chartPeriod=ChartPeriod(days: MarketPeriod.day_day, interval: "");
  int? timestampFrom;
  int? timestampTo;
  void changeChartPeriod(ChartPeriod value){
      if(chartPeriod!.days==value.days){

      }else{
        chartPeriod=value;
      }
      if(value.days==MarketPeriod.day_day){
        timestampTo=DateTime.now().millisecondsSinceEpoch;
        timestampFrom=(DateTime.now().millisecondsSinceEpoch)-1000*60*60*24;
      }else if(value.days==MarketPeriod.day_weekly){
        timestampTo=DateTime.now().millisecondsSinceEpoch;
        timestampFrom=(DateTime.now().millisecondsSinceEpoch)-1000*60*60*24*7;
      }else if(value.days==MarketPeriod.day_monthly){
        timestampTo=DateTime.now().millisecondsSinceEpoch;
        timestampFrom=(DateTime.now().millisecondsSinceEpoch)-1000*60*60*24*30;
      }
      log(timestampFrom.toString());
      log(timestampTo.toString());
      notifyListeners();
  }

  Future<void> getCoinMarkets()async{
    CoinGeckoResult<List<Market>> result=await _coinGeckoApi.coins.listCoinMarkets(vsCurrency: "usd");
    markets=result.data;
  }

  Future<Market?> getMarket(String coingeckoId)async{
    if(markets.isNotEmpty&&markets!=null){
      return markets.where((element) => element.id==coingeckoId).last;
    }else{
      return null;
    }
  }
}