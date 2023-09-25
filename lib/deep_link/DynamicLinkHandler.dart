import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:ryipay/route/AppRoute.dart';

class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks(context) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
      // Ex: https://namnp.page.link/product/013232
      final String path = dynamicLinkData.link.path; // Get PATH
      // Ex: product/013232
      if(deepLink.isEmpty)  return;
      handleDeepLink(path,context);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
    initUniLinks(context);
  }
  Future<void> initUniLinks(context) async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if(initialLink == null)  return;
      handleDeepLink(initialLink.link.path,context);
    } catch (e) {
      // Error
    }
  }
  void handleDeepLink(String path,BuildContext context) {
    // navigate to detailed product screen
    log(path);
    if(path=="splash"){
      Navigator.pushNamed(context, AppRoute.walletConnectScreen);
    }
  }
}