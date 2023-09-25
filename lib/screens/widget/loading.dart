import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/settings/theme/controller/theme_controller.dart';
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context,themeController,_) {
        return SizedBox(
          child: Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: button_color,
              secondRingColor: Colors.white54,
              size: 30.sp,
            ),
          ),
        );
      }
    );
  }
}
