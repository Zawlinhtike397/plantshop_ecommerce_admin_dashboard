import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Order Summary',
      child: Column(
        children: [
          DetailsRow(label: 'Payment', value: 'AYA Pay'),
          DetailsRow(label: 'SubTotal', value: '120000MMK'),
          DetailsRow(label: 'Discount', value: '1000MMK'),
          DetailsRow(label: 'Delivery Fee', value: '500MMK'),
          const SizedBox(height: 8),
          DetailsRow(label: 'Total', value: '110500MMK', isBold: false),
        ],
      ),
    );
  }
}
