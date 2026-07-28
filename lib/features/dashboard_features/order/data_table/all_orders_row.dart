import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class AllOrdersRows extends DataTableSource {
  final BuildContext context;
  final bool isDarkMode;
  final List<OrderModel> orders;

  AllOrdersRows({
    required this.context,
    required this.isDarkMode,
    required this.orders,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;

    final order = orders[index];
    final shortId = (order.id != null && order.id!.length >= 7)
        ? order.id!.substring(0, 7)
        : order.id ?? '-';
    final formattedDate = order.createdAt != null
        ? DateFormat('dd/MM/yyyy').format(order.createdAt!)
        : '-';
    final customerName = order.customerName ?? 'Mr.Bean';
    final orderItems = order.items ?? [];

    return DataRow2(
      specificRowHeight: 90,
      cells: [
        DataCell(
          Text(shortId, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Align(alignment: Alignment.center, child: Text(customerName))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: orderItems.map((item) {
                final plantName = item.plant?.name ?? 'Unknown Plant';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '${item.quantity} x $plantName',
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Order Date
        DataCell(
          Align(alignment: Alignment.center, child: Text(formattedDate)),
        ),
        // Price
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text('${order.totalAmount.toInt()} MMK'),
          ),
        ),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              order.status != null && order.status!.isNotEmpty
                  ? '${order.status![0].toUpperCase()}${order.status!.substring(1)}'
                  : 'Pending',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_horiz,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              color: isDarkMode ? AppColor.dark2 : AppColor.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isDarkMode
                      ? AppColor.dark3
                      : AppColor.borderColor.withValues(alpha: 0.5),
                ),
              ),
              onSelected: (String value) async {
                if (value == 'view detail') {
                  context.go(AppRoutes.orderDetail);
                } else if (value == 'delete') {
                } else if (value == 'export') {
                  try {} catch (e) {}
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'view detail',
                  child: Text(
                    'View Detail',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem<String>(
                  value: 'export',
                  child: Text(
                    'Export CSV',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}
