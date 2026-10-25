import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/dropdown/custom_dropdown.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:provider/provider.dart';

class ProductInformationWidget extends StatelessWidget {
  const ProductInformationWidget({super.key});

  void _showAddDialog(
    BuildContext context,
    String title,
    Function(String) onAdd,
  ) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter $title name'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onAdd(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

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
              fontSize: 16,
            ),
          ),
          Row(
            spacing: 5.0,
            children: [
              Expanded(
                child: Column(
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
                        border: Border.all(
                          width: 0.5,
                          color: AppColor.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: CustomDropdown(
                        isDarkMode: isDarkMode,
                        value: providerState.selectedCategory.isEmpty
                            ? providerState.categories.first
                            : providerState.selectedCategory,
                        itemsValue: providerState.categories,
                        onChanged: providerState.handleCategoryChanged,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    SizedBox(height: 13),
                    InkWell(
                      onTap: () => _showAddDialog(
                        context,
                        'Category',
                        providerState.addNewCategory,
                      ),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: AppColor.buttonPrimary,
                      ),
                    ),
                  ],
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
