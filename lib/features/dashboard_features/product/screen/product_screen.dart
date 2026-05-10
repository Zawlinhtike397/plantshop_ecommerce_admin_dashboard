import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/product_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/product_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/product_screen_tablet.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      useLayout: true,
      mobile: ProductScreenMobile(),
      tablet: ProductScreenTablet(),
      desktop: ProductScreenDesktop(),
    );
  }
}
