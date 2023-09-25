import 'dart:async';
import 'dart:developer';

import 'package:coingecko_api/data/market_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/coin_markets/constants/market_period.dart';
import 'package:ryipay/screens/home/Market/coin_markets/models/chart_duration_model.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';

import '../coin_markets/controller/CoinMarketController.dart';
class CoinChart extends StatefulWidget {
  List<MarketChartData> data;
  CoinChart({required this.data});

  @override
  State<CoinChart> createState() => _CoinChartTwoState();
}

class _CoinChartTwoState extends State<CoinChart> {
  List<Map<String,Object>> priceVolumeData=[];
  final priceVolumeStream = StreamController<GestureEvent>.broadcast();
  late CoinMarketController cmc;
  double min=0;
  late double max;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cmc=Provider.of<CoinMarketController>(context,listen: false);
    // widget.data.sort((a,b)=>a.date.hour.compareTo(b.date.hour));
    min= widget.data.reduce((a, b) => a.price!<b.price!?a:b).price!;
    max= widget.data.reduce((a, b) => a.price!>b.price!?a:b).price!;
    widget.data.map((e){
      return priceVolumeData.add({
        'date':e.date.toString(),
        'price':e.price!.toDouble(),
        'volume':e.totalVolume!.toDouble(),
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
        builder: (context,themeController,_) {
          return Consumer<CoinMarketController>(
              builder: (context,cmc,_) {
                return Container(
                  margin: EdgeInsets.all(8.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height*0.05,
                        child: Row(
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
                        ),
                      ),
                      Container(
                        height: height*0.2,
                        margin: EdgeInsets.all(8.sp),
                        child: Chart(
                          rebuild: false,
                          padding: (s){
                            return EdgeInsets.only(top: 8.sp,bottom: 8.sp,);
                          },
                          data: priceVolumeData,
                          tooltip: TooltipGuide(
                              backgroundColor: themeController.isDark?Colors.grey:primary_color_light,
                              textStyle: TextStyle(
                                  color: themeController.isDark?w60_text_color:lb_text_color
                              )
                          ),
                          variables: {
                            'date': Variable(
                              accessor: (Map map) => map['date'] as String,
                              scale: OrdinalScale(tickCount: 3,formatter: formatDate),
                            ),
                            'price': Variable(
                              accessor: (Map map) => map['price'] as num,
                              scale: LinearScale(min: min,max: max, tickCount: 0,niceRange: true),
                            ),
                          },
                          marks: [
                            LineMark(
                                size: SizeEncode(value: 1),
                                color: ColorEncode(value: button_color)
                            )
                          ],
                          axes: [
                            Defaults.horizontalAxis
                              ..label = null
                              ..line = null,
                            Defaults.verticalAxis
                              ..label = null
                              ..line = null,
                          ],
                          selections: {
                            'touchMove': PointSelection(
                              on: {
                                GestureType.scaleUpdate,
                                GestureType.tapDown,
                                GestureType.longPressMoveUpdate
                              },
                              dim: Dim.x,
                            )
                          },
                          crosshair: CrosshairGuide(
                            followPointer: [true, false],
                            styles: [
                              PaintStyle(
                                  strokeColor: themeController.isDark?Colors.white:Colors.black12, dash: [4, 2]),
                              PaintStyle(
                                  strokeColor: themeController.isDark?Colors.white:Colors.black12, dash: [4, 2]),
                            ],
                          ),
                          gestureStream: priceVolumeStream,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        height: height*0.1,
                        child: Chart(
                          padding: (s){
                            return EdgeInsets.only(top: 8.sp,bottom: 8.sp,);
                          },
                          tooltip: TooltipGuide(
                              backgroundColor: themeController.isDark?Colors.grey:primary_color_light,
                              textStyle: TextStyle(
                                  color: themeController.isDark?w60_text_color:lb_text_color
                              )
                          ),
                          rebuild: false,
                          data: priceVolumeData,
                          variables: {
                            'date': Variable(
                              accessor: (Map map) => map['date'] as String,
                              scale: OrdinalScale(tickCount: 3,formatter: formatDate),
                            ),
                            'volume': Variable(
                              accessor: (Map map) => map['volume'] as num,
                              scale: LinearScale(min: 0),
                            ),
                          },
                          marks: [
                            IntervalMark(
                                size: SizeEncode(value: 1.5),
                                color: ColorEncode(value: button_color.withOpacity(0.2))
                            )
                          ],
                          axes: [
                            Defaults.horizontalAxis
                                                        ],
                          selections: {
                            'touchMove': PointSelection(
                              on: {
                                GestureType.scaleUpdate,
                                GestureType.tapDown,
                                GestureType.longPressMoveUpdate
                              },
                              dim: Dim.x,
                            )
                          },
                          crosshair: CrosshairGuide(
                          followPointer: [true, false],
                          styles: [
                            PaintStyle(
                                strokeColor: primary_color, dash: [4, 2]),
                            PaintStyle(
                                strokeColor: primary_color, dash: [4, 2]),
                          ],
                        ),
                          gestureStream: priceVolumeStream,
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
    );
  }
  String formatDate(String time){
    var date=DateTime.parse(time);
    String? formattedDate;
    if(cmc.chartPeriod!.days==MarketPeriod.day_day){
      formattedDate = DateFormat('kk:mm').format(date);
    }else if(cmc.chartPeriod!.days==MarketPeriod.day_weekly){
      formattedDate = DateFormat('dd').format(date);
    }else{
      formattedDate = DateFormat('dd').format(date);
    }
    log(formattedDate);
    return formattedDate;
  }
}
