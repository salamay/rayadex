import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Market/news/model/news_model.dart' as newsModel;
import 'package:ryipay/screens/home/Market/news/widget/news_widget.dart';
import 'package:ryipay/screens/widget/loading.dart';

import 'controller/news_controller.dart';
class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin{

  AsyncMemoizer asyncMemoizer=AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.sp),
        height: height,
        width: width,
        child: Consumer<NewsController>(
          builder: (context,newsController,_) {
            return RefreshIndicator(
              backgroundColor: primary_color,
              color: Colors.white,
              onRefresh: ()async{
                asyncMemoizer=AsyncMemoizer();
                setState(() {

                });
              },
              child: SingleChildScrollView(
                child: FutureBuilder<dynamic>(
                    future: asyncMemoizer.runOnce(() => newsController.getCryptoNews(context)),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                        List<newsModel.Result> news=snapshot.data!;
                        return Column(
                          children: news.map((e) => GestureDetector(
                            onTap: (){

                            },
                            child: NewsWidget(
                              title: e.title,
                              content: e.content,
                              date: DateTime.parse(e.pubDate),
                            ),
                          )).toList(),
                        );
                      }else if(snapshot.hasError){
                        return SizedBox(
                          child: SmallText(
                            text: "Unable to get crypto news",
                            color: w60_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.center,
                            maxLines: 2,
                          ),
                        );
                      }else{
                        return const Loading();
                      }
                    }
                )
              ),
            );
          }
        ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
