import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/categories/responsive/category_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/categories/responsive/category_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/categories/responsive/category_screen_tablet.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      useLayout: true,
      mobile: CategoryScreenMobile(),
      tablet: CategoryScreenTablet(),
      desktop: CategoryScreenDesktop(),
    );
  }
}
