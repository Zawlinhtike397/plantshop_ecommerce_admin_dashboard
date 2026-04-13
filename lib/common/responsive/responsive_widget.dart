import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/sizes.dart';

class AppResponsiveWidget extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget desktopWidget;
  const AppResponsiveWidget({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
    required this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= Sizes.desktopScreenSize) {
          return desktopWidget;
        } else if (constraints.maxWidth < Sizes.desktopScreenSize &&
            constraints.maxWidth >= Sizes.tabletScreenSize) {
          return tabletWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}
