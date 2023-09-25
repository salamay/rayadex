import 'dart:developer';

import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/market_chart_data.dart';
import 'package:flutter/cupertino.dart';

class CoinInfoController extends ChangeNotifier{

  final _coinGeckoApi = CoinGeckoApi();
  int? previousWeekday;
  List<MarketChartData> chartData=[];
  Future<List<MarketChartData>?> coinMarketChart(String id,String currency,int days,String interval)async{
    try{
      chartData=[];
      final list= await _coinGeckoApi.coins.getCoinMarketChart(id: id, vsCurrency: currency,days: days,interval: interval);
      log(list.errorMessage.toString());
      chartData.addAll(list.data);
      chartData.removeLast();
      return chartData;
    }catch(e){
      log(e.toString());
      return null;
    }

  }
  Future<List<MarketChartData>?> tokenMarketChart(String id,String currency,int days,String interval)async{
    try{
      chartData=[];
      final list= await _coinGeckoApi.coins.getCoinMarketChart(id: id, vsCurrency: currency,days: days,interval: interval);
      chartData.addAll(list.data);
      chartData.removeLast();
      return chartData;
    }catch(e){
      log(e.toString());
      return null;
    }

  }
}