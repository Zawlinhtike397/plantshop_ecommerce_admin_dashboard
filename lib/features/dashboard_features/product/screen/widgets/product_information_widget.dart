import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/dropdown/custom_dropdown.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:provider/provider.dart';

class ProductInformationWidget extends StatelessWidget {
  const ProductInformationWidget({super.key});

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
            'Product Information',
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
                'Plant Categories',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 0.5, color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: CustomDropdown(
                  isDarkMode: isDarkMode,
                  value: providerState.selectedCategory.isEmpty
                      ? 'Outdoor'
                      : providerState.selectedCategory,
                  itemsValue: [
                    'Outdoor',
                    'Indoor',
                    'Gardening',
                    'Flowering',
                    'Hanging',
                  ],
                  onChanged: providerState.handleCategoryChanged,
                ),
              ),
            ],
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plant Height',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: providerState.heightController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(hintText: 'Plant Height (in cm)'),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'Height'),
              ),
            ],
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Minimum Temperature (In Celsius)',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: providerState.minTempController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                ],
                validator: (value) => Validator.validateMinTemperature(
                  value,
                  providerState.maxTempController.text,
                ),
                decoration: InputDecoration(hintText: 'Plant Temperature'),
              ),
            ],
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maximum Temperature (In Celsius)',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: providerState.maxTempController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                ],
                validator: (value) => Validator.validateMaxTemperature(
                  providerState.minTempController.text,
                  value,
                ),
                decoration: InputDecoration(hintText: 'Plant Temperature'),
              ),
            ],
          ),
          Column(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pot Type',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 0.5, color: AppColor.borderColor),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: CustomDropdown(
                  isDarkMode: isDarkMode,
                  value: providerState.selectedPotType.isEmpty
                      ? 'Ceramic pot'
                      : providerState.selectedPotType,
                  itemsValue: ['Ceramic pot', 'Plastic pot'],
                  onChanged: providerState.handlePotTypeChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
