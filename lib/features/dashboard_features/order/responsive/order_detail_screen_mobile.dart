import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/customers_details_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/delivery_address_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_summary_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_history_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_summary_card.dart';

class OrderDetailScreenMobile extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreenMobile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Detail',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              OrderHeader(order: order),
              const SizedBox(height: 24),
              CustomersDetailsCard(order: order),
              const SizedBox(height: 16),
              DeliveryAddressCard(),
              const SizedBox(height: 16),
              ItemSummaryCard(items: order.items ?? []),
              const SizedBox(height: 16),
              OrderHistoryCard(status: order.status ?? 'pending'),
              const SizedBox(height: 16),
              OrderSummaryCard(order: order),
            ],
          ),
        ),
      ),
    );
  }
}
