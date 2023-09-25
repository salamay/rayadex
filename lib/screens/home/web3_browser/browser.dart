import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryipay/screens/home/web3_browser/storage.dart' as st;
import 'package:ryipay/component/app_component.dart';

class Browser extends StatefulWidget {
  String urlString;
  bool save;
  Browser({Key? key,required this.urlString,required this.save}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final GlobalKey webViewKey = GlobalKey();
  List<dynamic> history = [];
  List<dynamic> bookmarks = [];

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  double progress = 0;
  late PullToRefreshController pullToRefreshController;
  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    _loadBookmarksAndHistory();
    super.initState();
  }

  _loadBookmarksAndHistory() async {
    history = (await st.Storage.readData('history') ?? []).toList();
    bookmarks = (await st.Storage.readData('bookmarks') ?? []).toList();
    setState(() {});
  }

  _saveHistory() async {
    if (widget.save == true) {
      await st.Storage.saveData('bookmarks', bookmarks);
      await st.Storage.saveData('history', history);
    }
  }

  _saveBookmarks() async {
    if (widget.save == true) {
      await st.Storage.saveData('bookmarks', bookmarks);
      await st.Storage.saveData('history', history);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          backgroundColor: primary_color,
          onPressed: () async {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(widget.urlString)),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStop: (controller, url) async {
            if (url != null && !history.contains(url.toString())) {
              history = (await st.Storage.readData('history') ?? []).toList();
              history.add(url.toString());
              _saveHistory();
            }
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
