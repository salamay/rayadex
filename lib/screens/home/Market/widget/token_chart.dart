import 'dart:developer';

import 'package:coingecko_api/data/market_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/coin_markets/constants/market_period.dart';
import 'package:ryipay/screens/home/Market/coin_markets/controller/CoinMarketController.dart';
import 'package:ryipay/screens/home/Market/coin_markets/models/chart_duration_model.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';


class TokenChart extends StatefulWidget {
  List<MarketChartData> data;
  TokenChart({required this.data});

  @override
  State<TokenChart> createState() => _TokenChartState();
}

class _TokenChartState extends State<TokenChart> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.blue
  ];
  late ThemeController themeController;
  // List<MarketChartData> plots=[];

  @override
  void initState() {
    // TODO: implement initState
    themeController=Provider.of<ThemeController>(context,listen: false);
    var cmc=Provider.of<CoinMarketController>(context,listen: false);
    //log(cmc.chartPeriod!.days.toString());
    // if(cmc.chartPeriod!.days==MarketPeriod.day_day){
    //   widget.data.sort((a,b)=>a.date.hour.compareTo(b.date.hour));
    //   for(int i=0;i<widget.data.length;i++){
    //     if(i%12==0){
    //       plots.add(widget.data[i]);
    //     }
    //   }
    // }else if(cmc.chartPeriod!.days==MarketPeriod.day_weekly){
    //   widget.data.sort((a,b)=>a.date.weekday.compareTo(b.date.weekday));
    //   for(int i=0;i<widget.data.length;i++){
    //     if(i%18==0){
    //       plots.add(widget.data[i]);
    //     }
    //   }
    // }else{
    //   widget.data.sort((a,b)=>a.date.day.compareTo(b.date.day));
    //   for(int i=0;i<widget.data.length;i++){
    //     if(i%24==0){
    //       plots.add(widget.data[i]);
    //     }
    //   }
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        margin: EdgeInsets.all(8.sp),
        child: Consumer<ThemeController>(
            builder: (context,themeController,_) {
              return Consumer<CoinMarketController>(
                builder: (context,cmc,_) {
                  return Column(
                    children: [
                      Consumer<CoinMarketController>(
                          builder: (context,cmc,child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    cmc.changeChartPeriod(ChartPeriod(days: MarketPeriod.day_day, interval: MarketPeriod.hourly));
                                  },
                                  child: Container(
                                      width:width*0.1,
                                      decoration: BoxDecoration(
                                          color: themeController.isDark?cmc.chartPeriod!.days==MarketPeriod.day_monthly?primary_color_light:Colors.transparent:cmc.chartPeriod!.days==MarketPeriod.day_monthly?Colors.grey:Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SmallText(
                                            text: "24H",
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                            align: TextAlign.center
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(width: 5.sp,),
                                GestureDetector(
                                  onTap: (){
                                    cmc.changeChartPeriod(ChartPeriod(days: MarketPeriod.day_weekly, interval: MarketPeriod.daily));
                                  },
                                  child: Container(
                                      width:width*0.1,
                                      decoration: BoxDecoration(
                                          color: themeController.isDark?cmc.chartPeriod!.days==MarketPeriod.day_monthly?primary_color_light:Colors.transparent:cmc.chartPeriod!.days==MarketPeriod.day_monthly?Colors.grey:Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SmallText(
                                            text: "7D",
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                            align: TextAlign.center
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(width: 5.sp,),
                                GestureDetector(
                                  onTap: (){
                                    cmc.changeChartPeriod(ChartPeriod(days: MarketPeriod.day_monthly, interval: MarketPeriod.daily));
                                  },
                                  child: Container(
                                      width:width*0.1,
                                      decoration: BoxDecoration(
                                          color: themeController.isDark?cmc.chartPeriod!.days==MarketPeriod.day_monthly?primary_color_light:Colors.transparent:cmc.chartPeriod!.days==MarketPeriod.day_monthly?Colors.grey:Colors.transparent,
                                          borderRadius: BorderRadius.all(Radius.circular(10.sp))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SmallText(
                                            text: "1M",
                                            color: Colors.white,
                                            weight: FontWeight.bold,
                                            align: TextAlign.center
                                        ),
                                      )
                                  ),
                                )
                              ],
                            );
                          }
                      ),
                      Stack(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1.70,
                            child: LineChart(
                              mainData(cmc),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              );
            }
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var cmc=Provider.of<CoinMarketController>(context,listen: false);
    TextStyle style = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 11.sp,
        color: themeController.isDark?w_text_color:lb_text_color
    );
    Widget text=Text("de");
    if(cmc.chartPeriod!.days==1){
      if(value.toInt()%12==0&&value.toInt()!=0||value%2==0){
        text=Text(value.toInt().toString(), style: style);
      }else{
        text=Text("", style: style);
      }
    }else if(cmc.chartPeriod!.days==7){
      if(value.toInt()!=0){
        switch (value.toInt()) {
          case 1:
            break;
          case 2:
            text = Text('Tue', style: style);
            break;
          case 3:
            text = Text('Wed', style: style);
            break;
          case 4:
            text = Text('Thur', style: style);
            break;
          case 5:
            text = Text('Fri', style: style);
            break;
          case 6:
            text = Text('Sat', style: style);
            break;
          case 7:
            text = Text('Sun', style: style);
            break;
          default:
            text = Text('', style: style);
            break;
        }
      }
    }else{
      if(value.toInt()%48==0&&value.toInt()!=0||value%4==0){
        text = Text(value.toInt().toString(), style: style);
      }else{
        text = Text("", style: style);
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return const SizedBox();
  }

  LineChartData mainData(CoinMarketController cmc) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white60,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: false
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 0,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          curveSmoothness: 0.1 ,
          spots: widget.data.map((e) {
            //log(e.date.toString());
            if(cmc.chartPeriod!.days==MarketPeriod.day_day){
              return FlSpot(e.date.hour.toDouble(), double.parse(e.price!.toStringAsFixed(2)));
            }else if(cmc.chartPeriod!.days==MarketPeriod.day_weekly){
              return FlSpot(e.date.day.toDouble(), double.parse(e.price!.toStringAsFixed(2)));
            }else{
              return FlSpot(e.date.day.toDouble(), double.parse(e.price!.toStringAsFixed(2)));
            }
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.2))
                    .toList(),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
        ),
      ],
    );
  }
}
