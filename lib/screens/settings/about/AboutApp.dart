import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/api/url/Api_url.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Provider.of<ThemeController>(context,listen: false).isDark?primary_color:Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiUrls.aboutApp));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: themeController.isDark?Colors.white:Colors.black,
                size: getBigIconSize(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },

            ),
            title: Text(
              "About",
              style: TextStyle(
                  fontSize: 24.sp
              ),
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: WebViewWidget(controller: controller),
          ),
        );
      }
    );
  }
}
