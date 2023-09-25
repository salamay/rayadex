import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/snackbar/error_snackbar.dart';
import 'package:ryipay/screens/home/Market/news/model/news_model.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';

class NewsController extends ChangeNotifier{

  final my_api=MyApi();

  Future<List<Result>?> getCryptoNews(context) async {
      try {
        var response = await my_api.get(ApiUrls.cryptoNews,{"Content-Type": "application/json"});
        if (response!.statusCode == 200) {
          log(response.statusCode.toString());
          return newsModelFromJson(response.body).results;
        } else {
          ShowSnackBar.show(context, "Unable to get crypto news",Colors.red);
          return null;
        }
      } catch (e) {
        log(e.toString());
        ShowSnackBar.show(context, "Unable to establish connection",Colors.red);
        return null;
      }
  }
}