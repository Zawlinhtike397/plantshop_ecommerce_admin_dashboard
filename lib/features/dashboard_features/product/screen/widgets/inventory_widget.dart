import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:provider/provider.dart';

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final providerState = context.watch<ProductProvider>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColor.borderColor),
        color: isDarkMode ? AppColor.dark1 : AppColor.white,
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25.0,
        children: [
          Text(
            'Inventory and Plant Status',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current stock',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: providerState.stockController,
                validator: (value) => Validator.validateIsEmpty(value, 'Stock'),
                decoration: InputDecoration(
                  hintText: 'current stock count (eg, 50)',
                ),
              ),
            ],
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maximum Stock',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: providerState.maxStockController,
                validator: (value) => Validator.validateIsEmpty(value, 'Stock'),
                decoration: InputDecoration(
                  hintText: 'Maximum stock count for the product (eg, 200)',
                ),
              ),
            ],
          ),
          CheckboxListTile(
            title: Text(
              'isActive',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Customers can see and purchase this plant.',
              style: TextStyle(color: AppColor.midGray),
            ),
            value: context.watch<ProductProvider>().isActive,
            onChanged: (bool? value) {
              context.read<ProductProvider>().toggleActiveStatus(
                value ?? false,
              );
            },
            activeColor: AppColor.primary,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
