import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/timeline_widget.dart';

class OrderHistoryCard extends StatelessWidget {
  final String status;
  const OrderHistoryCard({super.key, required this.status});

  int _getStatusIndex(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'processing':
        return 1;
      case 'shipping':
        return 2;
      case 'delivered':
        return 3;
      case 'cancel':
      case 'cancelled':
        return -1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusIndex = _getStatusIndex(status);
    final isCancelled = statusIndex == -1;

    return BaseCard(
      title: 'Order History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCancelled)
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                'This order has been cancelled.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          TimelineWidget(
            text: 'Payment Confirmed (Pending)',
            isCompleted: !isCancelled && statusIndex >= 0,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Processing your plants(Processing)',
            isCompleted: !isCancelled && statusIndex >= 1,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Shipping your plants(Shipping)',
            isCompleted: !isCancelled && statusIndex >= 2,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Delivered your plants',
            isCompleted: !isCancelled && statusIndex >= 3,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
