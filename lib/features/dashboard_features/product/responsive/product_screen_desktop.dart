import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/data_table.dart/all_products_data_table.dart';

class ProductScreenDesktop extends StatelessWidget {
  const ProductScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 24),

            AllProductsDataTable(),
          ],
        ),
      ),
    );
  }
}
