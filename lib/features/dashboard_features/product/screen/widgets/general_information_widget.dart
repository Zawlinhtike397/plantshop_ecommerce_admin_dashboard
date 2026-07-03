import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:provider/provider.dart';

class GeneralInformationWidget extends StatelessWidget {
  const GeneralInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final formState = context.watch<ProductProvider>();

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.dark1 : AppColor.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color.fromARGB(255, 222, 221, 221)),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25.0,
        children: [
          Text(
            'General Information',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Plant name',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: formState.nameController,
                decoration: InputDecoration(hintText: 'Enter plant name'),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'Plant name'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: formState.descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter plant description',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'Plant description'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
