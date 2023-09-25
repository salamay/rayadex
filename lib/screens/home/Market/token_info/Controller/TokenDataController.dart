import 'dart:convert';
import 'dart:developer';

import 'package:ryipay/api/my_api.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/screens/home/Market/token_info/model/TokenData.dart';
import 'package:ryipay/screens/widget/show_snack_bar.dart';

class TokenDataController{

  final my_api = MyApi();


  Future<TokenData> getTokenData(context,String platformId, String address) async {
    try {
      log("Getting doge tx");
      var response = await my_api.get("${ApiUrls.tokenData}/$platformId/contract/$address", {"Content-Type": "application/json"});
      if (response!.statusCode == 200) {
        log(response.statusCode.toString());
        final tokenData = tokenDataFromJson(response.body);
        log("dhgfydsfhvdsvhdshvhdsuhfvdfsuv");
        return tokenData;
      } else {
        throw Exception("Return ${response.statusCode.toString()}");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

}