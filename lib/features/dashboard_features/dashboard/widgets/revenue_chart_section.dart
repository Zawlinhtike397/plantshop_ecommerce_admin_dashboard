import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/sale_revenue_charts.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';

class RevenueChartSection extends StatelessWidget {
  const RevenueChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrderLoaded) {
          if (state.orders.isEmpty) {
            SalesRevenueChart(orders: []);
          }
          return SalesRevenueChart(orders: state.orders);
        }

        if (state is OrderError) {
          return SizedBox(
            height: 350,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load chart data',
                    style: TextStyle(color: Colors.red.shade400, fontSize: 16),
                  ),

                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(FetchOrders());
                      print(state.message);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
