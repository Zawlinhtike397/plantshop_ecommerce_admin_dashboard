import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/sizes.dart';

class DeviceUtility {
  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= Sizes.desktopScreenSize;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= Sizes.tabletScreenSize &&
        MediaQuery.of(context).size.width < Sizes.desktopScreenSize;
  }

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < Sizes.tabletScreenSize;
  }
}
