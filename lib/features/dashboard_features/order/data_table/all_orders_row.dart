import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/table_action_menu.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/csv_export_services.dart';
import 'package:toastification/toastification.dart';

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
          TableActionMenu(
            isDarkMode: isDarkMode,
            onSelected: (String value) async {
              if (value == 'view detail') {
                context.go(AppRoutes.orderDetailPath(order.id!), extra: order);
              } else if (value == 'export') {
                try {
                  final formattedStatus =
                      order.status != null && order.status!.isNotEmpty
                      ? '${order.status![0].toUpperCase()}${order.status!.substring(1)}'
                      : 'Pending';

                  final itemsText = orderItems
                      .map((item) {
                        final plantName = item.plant?.name ?? 'Unknown Plant';
                        return '${item.quantity} x $plantName';
                      })
                      .join('; ');

                  await CsvExportService.exportTable(
                    headers: [
                      'Order ID',
                      'Customer Name',
                      'Order Items',
                      'Order Date',
                      'Total Amount (MMK)',
                      'Status',
                    ],
                    rows: [
                      [
                        order.id ?? '-',
                        customerName,
                        itemsText,
                        formattedDate,
                        order.totalAmount.toInt(),
                        formattedStatus,
                      ],
                    ],
                    fileName: 'order_${shortId}_data',
                  );

                  if (context.mounted) {
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      style: ToastificationStyle.flatColored,
                      title: const Text('Export Complete'),
                      description: Text('Order $shortId data downloaded.'),
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 3),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    toastification.show(
                      context: context,
                      type: ToastificationType.error,
                      style: ToastificationStyle.flatColored,
                      title: const Text('Export Failed'),
                      description: const Text(
                        'Unable to export order data. Please try again.',
                      ),
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 3),
                    );
                  }
                }
              }
            },
            items: [
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
