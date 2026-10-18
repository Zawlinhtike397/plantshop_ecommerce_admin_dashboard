import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/responsive/order_detail_screen_desktop.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/responsive/order_detail_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/responsive/order_detail_screen_tablet.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel? order;
  final String? orderId;

  const OrderDetailScreen({super.key, this.order, this.orderId});

  @override
  Widget build(BuildContext context) {
    if (order != null) {
      return _buildOrderDetail(order!);
    }

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          OrderModel? foundOrder;

          try {
            foundOrder = state.filteredOrders.firstWhere(
              (o) => o.id == orderId,
            );
          } catch (_) {
            foundOrder = null;
          }

          if (foundOrder != null) {
            return _buildOrderDetail(foundOrder);
          }

          return const Scaffold(body: Center(child: Text('Order not found.')));
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildOrderDetail(OrderModel orderToShow) {
    return LayoutTemplate(
      useLayout: true,
      mobile: OrderDetailScreenMobile(order: orderToShow),
      tablet: OrderDetailScreenTablet(order: orderToShow),
      desktop: OrderDetailScreenDesktop(order: orderToShow),
    );
  }
}
