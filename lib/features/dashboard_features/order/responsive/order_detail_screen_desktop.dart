import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/customers_details_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/delivery_address_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_summary_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_history_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_summary_card.dart';

class OrderDetailScreenDesktop extends StatelessWidget {
  const OrderDetailScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
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

            OrderHeader(),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: CustomersDetailsCard()),
                          const SizedBox(width: 24),
                          Expanded(child: DeliveryAddressCard()),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ItemSummaryCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),

                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      OrderHistoryCard(),
                      const SizedBox(height: 24),
                      OrderSummaryCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
