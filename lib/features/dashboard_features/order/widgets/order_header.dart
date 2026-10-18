import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';

class OrderHeader extends StatelessWidget {
  final OrderModel order;
  const OrderHeader({super.key, required this.order});

  bool _canUpdateStatus(String? status) {
    if (status == null) return true;

    final currentStatus = status.toLowerCase();

    return currentStatus != 'delivered' && currentStatus != 'cancelled';
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = order.createdAt != null
        ? "${order.createdAt!.day}/${order.createdAt!.month}/${order.createdAt!.year}"
        : "Unknown";

    final orderId = order.id ?? '';
    final displayId = orderId.length >= 5
        ? orderId.substring(0, 5)
        : (orderId.isNotEmpty ? orderId : 'N/A');

    return Row(
      children: [
        Text(
          'ID: ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          displayId,
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 32),
        Text(
          'Order created: ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          dateStr,
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
        const Spacer(),
        if (_canUpdateStatus(order.status))
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (order.id != null) {
                context.read<OrderBloc>().add(
                  UpdateOrderStatusEvent(orderId: order.id!, status: value),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'pending',
                child: Text('Mark as Pending', style: TextStyle(fontSize: 12)),
              ),
              const PopupMenuItem<String>(
                value: 'processing',
                child: Text(
                  'Marked as Processing',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'shipping',
                child: Text(
                  'Marked as Shipping',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'delivered',
                child: Text(
                  'Marked as Delivered',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'cancelled',
                child: Text(
                  'Cancel your plant',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
