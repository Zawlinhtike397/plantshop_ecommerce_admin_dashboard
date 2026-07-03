import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/provider/product_provider.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:provider/provider.dart';

class CareGuideWidget extends StatelessWidget {
  const CareGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final providerState = context.watch<ProductProvider>();

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
            'Care guide',
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
                'Light',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.lightController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter brief description about light',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'the description'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Water',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.waterController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter brief description about water',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'the description'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Humidity',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.humidityController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter brief description about humidity',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'the description'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Soil',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.soilController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter brief description about soil',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'the description'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              Text(
                'Pet Safety',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextFormField(
                controller: providerState.petSafetyController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter brief description about pet safety',
                ),
                validator: (value) =>
                    Validator.validateIsEmpty(value, 'the description'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
