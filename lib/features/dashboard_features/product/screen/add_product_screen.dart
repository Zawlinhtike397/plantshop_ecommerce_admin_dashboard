import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/add_product_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/add_product_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/add_product_screen_tablet.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: LayoutTemplate(
        useLayout: true,
        mobile: AddProductScreenMobile(),
        tablet: AddProductScreenTablet(),
        desktop: AddProductScreenDesktop(),
      ),
    );
  }
}
