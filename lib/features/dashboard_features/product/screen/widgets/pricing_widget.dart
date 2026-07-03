import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({super.key});

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
            'Pricing',
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
                'Base Pricing (In MMK)',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'Plant Price'),
                decoration: InputDecoration(hintText: 'Base Price (eg, 2000)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
