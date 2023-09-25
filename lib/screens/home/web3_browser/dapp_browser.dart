import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/route/AppRoute.dart';
import 'bookmarks.dart';
import 'custom_textfield.dart';
import 'histories.dart';

class DAppBrowser extends StatefulWidget {
  const DAppBrowser({super.key});

  @override
  State<DAppBrowser> createState() => _DAppBrowserState();
}

class _DAppBrowserState extends State<DAppBrowser> with SingleTickerProviderStateMixin {
  TextEditingController urlController=TextEditingController();
  late String error="";
  late String value="";
  late String dappSearchUrl="";
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      log("Selected Index: ${_controller.index}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _parseAndLoadUrl(String value) {
    Uri? uri = Uri.tryParse(value);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      Navigator.pushNamed(context, AppRoute.browser,arguments: {
        "url": value,
        "save": true,
      },
      );
      // webViewController?.loadUrl(urlRequest: URLRequest(url: uri));
    } else if (uri != null && uri.scheme == '') {
      Navigator.pushNamed(context, AppRoute.browser,arguments: {
        "url": "https://$value",
        "save": true,
      },
      );
    } else {
      // Otherwise, treat it as a Google search
      Navigator.pushNamed(context, AppRoute.browser,arguments: {
        "url": "https://www.google.com/search?q=$value",
        "save": true,
      },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: DefaultTabController(
            length: 2,
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Row(
                    children: [
                      MediumText(
                        text: "Browser",
                        color: Colors.white,
                        weight: FontWeight.normal,
                        align: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  CustomTextField(
                    hint: "Search or enter a website url",
                    controller: urlController,
                    error: error,
                    inputType: TextInputType.emailAddress,
                    validFunction: (v) => v!,
                    prefixIcon: Icon(
                      Icons.search,
                      color: primary_color,
                    ),
                    onSavedFunction: (s) => {
                      if (s.isNotEmpty){
                          value = '',
                        dappSearchUrl = s,
                          //print(email);
                        }
                      else {
                          value = "Please enter web serach",
                        dappSearchUrl = '',
                        }
                    },
                    onSubmitFunction: (value) {
                      log(value);
                      _parseAndLoadUrl(value);
                    },
                  ),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    height: 40.sp,
                    child: TabBar(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      dividerColor: Colors.white.withOpacity(0.4),
                      indicatorColor: primary_color,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          icon: MediumText(
                            text: "History",
                            color: _selectedIndex == 0
                                ? w_text_color
                                : w60_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.start,
                            maxLines: 14,
                          )
                        ),
                        Tab(
                          icon:  MediumText(
                            text: "Bookmark",
                            color: _selectedIndex == 1
                                ? w_text_color
                                : w60_text_color,
                            weight: FontWeight.normal,
                            align: TextAlign.start,
                            maxLines: 14,
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      children: const <Widget>[
                        Histories(),
                        Bookmarks(),
                        //NFTDisplay(),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
