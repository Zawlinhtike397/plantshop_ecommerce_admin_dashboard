import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/responsive/responsive_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/responsive/screens/desktop_layout.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/responsive/screens/mobile_layout.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/responsive/screens/tablet_layout.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget? mobile, tablet, desktop;
  final bool useLayout;
  const LayoutTemplate({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    required this.useLayout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppResponsiveWidget(
        mobileWidget: useLayout
            ? MobileLayout(body: mobile ?? desktop)
            : mobile ?? desktop ?? Container(),
        tabletWidget: useLayout
            ? TabletLayout(body: tablet ?? desktop)
            : tablet ?? desktop ?? Container(),
        desktopWidget: useLayout
            ? DesktopLayout(body: desktop)
            : desktop ?? Container(),
      ),
    );
  }
}
