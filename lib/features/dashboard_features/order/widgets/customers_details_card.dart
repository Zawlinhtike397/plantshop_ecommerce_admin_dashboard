import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class CustomersDetailsCard extends StatelessWidget {
  final OrderModel order;

  const CustomersDetailsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Customer Details',
      child: Column(
        children: [
          DetailsRow(label: 'Name', value: order.customerName ?? 'N/A'),
          DetailsRow(label: 'Email', value: order.customerEmail ?? 'N/A'),
          DetailsRow(label: 'Phone', value: order.address?.phone ?? 'N/A'),
        ],
      ),
    );
  }
}
