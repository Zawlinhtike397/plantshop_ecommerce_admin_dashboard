import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class CustomersDetailsCard extends StatelessWidget {
  const CustomersDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Customer Details',
      child: Column(
        children: [
          DetailsRow(label: 'Name', value: 'zoro'),
          DetailsRow(label: 'Email', value: 'zoro@gmail.com'),
          DetailsRow(label: 'Phone', value: '233232232'),
        ],
      ),
    );
  }
}
