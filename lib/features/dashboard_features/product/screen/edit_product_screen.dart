import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_tablet.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  final PlantModel plant;
  const EditProductScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        final provider = ProductProvider();
        provider.initializeEditForm(plant);
        return provider;
      },
      child: LayoutTemplate(
        useLayout: true,
        mobile: EditProductScreenMobile(),
        tablet: EditProductScreenTablet(),
        desktop: EditProductScreenDesktop(),
      ),
    );
  }
}
