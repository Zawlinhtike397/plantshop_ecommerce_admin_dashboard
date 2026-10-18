import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/customers_details_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/delivery_address_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_summary_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_history_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_summary_card.dart';

class OrderDetailScreenTablet extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreenTablet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
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
              const SizedBox(width: 16),
              OrderHeader(order: order),
              const SizedBox(width: 24),
              Row(
                children: [
                  Expanded(child: CustomersDetailsCard(order: order)),
                  const SizedBox(width: 16),
                  Expanded(child: DeliveryAddressCard(address: order.address)),
                ],
              ),
              const SizedBox(height: 16),
              ItemSummaryCard(items: order.items ?? []),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OrderHistoryCard(status: order.status ?? 'pending'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: OrderSummaryCard(order: order)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
