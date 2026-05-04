import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';

class FullscreenLoader {
  static void showLoader(BuildContext context, {String? text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColor.darkBackground
                : AppColor.primaryBackground,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                spacing: 20.0,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(ImageStrings.loadingAnimation),
                  Text(
                    text ?? 'Please wait',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
