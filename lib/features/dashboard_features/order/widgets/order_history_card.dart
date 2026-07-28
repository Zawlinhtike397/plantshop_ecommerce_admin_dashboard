import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/timeline_widget.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Order History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimelineWidget(
            text: 'Payment Confirmed (Pending)',
            isCompleted: true,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Processing your plants(Processing)',
            isCompleted: true,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Shipping your plants(Shipping)',
            isCompleted: true,
            isLast: false,
          ),
          TimelineWidget(
            text: 'Delivered your plants',
            isCompleted: true,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
