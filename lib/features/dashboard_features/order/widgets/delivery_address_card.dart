import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/customer/model/address_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class DeliveryAddressCard extends StatelessWidget {
  final AddressModel? address;
  const DeliveryAddressCard({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Delivery Address',
      child: Column(
        children: [
          // DetailsRow(label: 'Contact Name:', value: 'Gym'),
          DetailsRow(label: 'Home no:', value: address?.homeNo ?? 'N/A'),
          DetailsRow(label: 'Street:', value: address?.street ?? 'N/A'),
          DetailsRow(label: 'Town', value: address?.city ?? 'N/A'),
        ],
      ),
    );
  }
}
