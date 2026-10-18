import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/table_action_menu.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/bloc/discount_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/model/discount_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/screen/widgets/add_edit_discount_dialog.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/csv_export_services.dart';
import 'package:toastification/toastification.dart';

class AllDiscountsRows extends DataTableSource {
  final BuildContext context;
  final List<DiscountModel> discounts;
  final bool isDarkMode;

  AllDiscountsRows({
    required this.context,
    required this.discounts,
    required this.isDarkMode,
  });

  void _showDeleteConfirmation(DiscountModel discount) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: isDarkMode ? AppColor.dark2 : Colors.white,
          title: Text(
            'Confirm Deletion',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete discount "${discount.code}"?\nThis action cannot be undone.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<DiscountBloc>().add(DeleteDiscount(discount.id));
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Delete',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColor.textWhite),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportDiscount(DiscountModel discount) async {
    try {
      await CsvExportService.exportSingleDiscount(discount);

      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          title: const Text('Export Complete'),
          description: Text('Discount ${discount.code} data downloaded.'),
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
            'Unable to export discount data. Please try again.',
          ),
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  DataRow? getRow(int index) {
    if (index >= discounts.length) return null;

    final discount = discounts[index];

    Widget cell(String value) {
      return Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black,
            fontSize: 12,
          ),
        ),
      );
    }

    return DataRow2(
      specificRowHeight: 70,
      cells: [
        DataCell(cell(discount.code)),
        DataCell(cell(discount.title)),
        DataCell(cell('${discount.percentage}%')),
        DataCell(cell('${discount.minAmount} MMK')),
        DataCell(cell(discount.isActive.toString())),
        DataCell(cell(discount.firstTimeOnly.toString())),
        DataCell(
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...discount.rules
                      .take(2)
                      .map(
                        (rule) => SizedBox(
                          width: double.infinity,
                          child: Tooltip(
                            message: rule,
                            child: Text(
                              '• $rule',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                  if (discount.rules.length > 2)
                    Tooltip(
                      message: discount.rules.skip(2).join('\n'),
                      child: Text(
                        '+${discount.rules.length - 2} more rules',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        DataCell(cell(DateFormat('dd/MM/yyyy').format(discount.validUntil))),
        DataCell(
          TableActionMenu(
            isDarkMode: isDarkMode,
            onSelected: (String value) async {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AddEditDiscountDialog(discount: discount);
                  },
                );
              } else if (value == 'delete') {
                _showDeleteConfirmation(discount);
              } else if (value == 'export') {
                await _exportDiscount(discount);
              }
            },
            items: [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text(
                  'Edit',
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => discounts.length;

  @override
  int get selectedRowCount => 0;
}
