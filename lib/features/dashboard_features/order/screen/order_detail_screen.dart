import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/responsive/order_detail_screen_desktop.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      useLayout: true,
      // mobile: OrderScreenMobile(),
      // tablet: OrderScreenTablet(),
      desktop: OrderDetailScreenDesktop(),
    );
  }
}
