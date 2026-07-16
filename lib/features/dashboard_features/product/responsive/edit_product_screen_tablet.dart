import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/care_guide_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/general_information_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/inventory_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/pricing_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/product_information_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/widgets/product_media_widget.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class EditProductScreenTablet extends StatelessWidget {
  const EditProductScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final providerState = context.watch<ProductProvider>();
    final formKey = providerState.editFormKey;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductActionSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.go(AppRoutes.products);
        } else if (state is ProductError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Text(
                    'Edit Plant Data',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.0,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15.0,
                          children: [
                            GeneralInformationWidget(),
                            ProductMediaWidget(),
                            ProductInformationWidget(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 15.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InventoryWidget(),
                            PricingWidget(),
                            CareGuideWidget(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 10,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.go(AppRoutes.products);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 20,
                                        ),
                                      ),
                                      onPressed: state is ProductLoading
                                          ? null
                                          : () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                providerState
                                                    .submitEditedProduct(
                                                      context,
                                                    );
                                              }
                                            },
                                      child: Text(
                                        'Edit Plant',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
