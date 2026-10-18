import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/customers_details_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/delivery_address_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_summary_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_history_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/order_summary_card.dart';

class OrderDetailScreenDesktop extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreenDesktop({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          OrderModel currentOrder = order;
          if (state is OrderLoaded) {
            currentOrder = state.orders.firstWhere(
              (o) => o.id == order.id,
              orElse: () => order,
            );
          }

          return SingleChildScrollView(
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

                OrderHeader(order: currentOrder),
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
                              Expanded(
                                child: CustomersDetailsCard(order: order),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: DeliveryAddressCard(
                                  address: order.address,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ItemSummaryCard(items: order.items ?? []),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),

                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          OrderHistoryCard(
                            status: currentOrder.status ?? 'pending',
                          ),
                          const SizedBox(height: 24),
                          OrderSummaryCard(order: currentOrder),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
