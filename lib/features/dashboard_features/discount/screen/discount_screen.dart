import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/responsive/discount_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/responsive/discount_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/responsive/discount_screen_tablet.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      useLayout: true,
      mobile: DiscountScreenMobile(),
      tablet: DiscountScreenTablet(),
      desktop: DiscountScreenDesktop(),
    );
  }
}
