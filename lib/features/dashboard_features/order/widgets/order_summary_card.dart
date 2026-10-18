import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/details_row.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderModel order;
  const OrderSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Order Summary',
      child: Column(
        children: [
          DetailsRow(
            label: 'Payment',
            value: order.paymentMethod.isNotEmpty ? order.paymentMethod : 'N/A',
          ),
          DetailsRow(
            label: 'SubTotal',
            value: '${order.subTotal.toStringAsFixed(0)} MMK',
          ),
          DetailsRow(
            label: 'Discount',
            value: '${order.discount.toStringAsFixed(0)} MMK',
          ),
          DetailsRow(
            label: 'Delivery Fee',
            value: '${order.deliveryFee.toStringAsFixed(0)} MMK',
          ),
          const SizedBox(height: 8),
          DetailsRow(
            label: 'Total',
            value: '${order.totalAmount.toStringAsFixed(0)} MMK',
            isBold: false,
          ),
        ],
      ),
    );
  }
}
