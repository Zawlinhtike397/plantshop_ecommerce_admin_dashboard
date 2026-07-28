import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Delivery Address',
      child: Column(
        children: [
          DetailsRow(label: 'Contact Name:', value: 'Gym'),
          DetailsRow(label: 'Home no:', value: '34343'),
          DetailsRow(label: 'Street:', value: 'KyanGyi'),
          DetailsRow(label: 'Town', value: 'Hledan'),
        ],
      ),
    );
  }
}
