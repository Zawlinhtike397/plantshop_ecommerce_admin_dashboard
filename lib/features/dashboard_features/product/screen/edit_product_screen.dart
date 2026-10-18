import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/responsive/edit_product_screen_tablet.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  final PlantModel? plant;
  final String? plantId;

  const EditProductScreen({super.key, this.plant, this.plantId});

  @override
  Widget build(BuildContext context) {
    if (plant != null) {
      return _buildEditForm(plant!);
    }

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          final foundPlant = state.filteredProducts.firstWhere(
            (p) => p.id == plantId,
            orElse: () => PlantModel.empty(),
          );

          if (foundPlant.id.isNotEmpty) {
            return _buildEditForm(foundPlant);
          }

          return const Scaffold(
            body: Center(child: Text('Product not found.')),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildEditForm(PlantModel plantToEdit) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        final provider = ProductProvider();
        provider.initializeEditForm(plantToEdit);
        return provider;
      },
      child: const LayoutTemplate(
        useLayout: true,
        mobile: EditProductScreenMobile(),
        tablet: EditProductScreenTablet(),
        desktop: EditProductScreenDesktop(),
      ),
    );
  }
}
