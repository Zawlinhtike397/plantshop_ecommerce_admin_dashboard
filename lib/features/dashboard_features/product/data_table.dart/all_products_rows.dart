import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/edit_product_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/csv_export_services.dart';
import 'package:toastification/toastification.dart';

class AllProductsRows extends DataTableSource {
  final BuildContext context;
  final bool isDarkMode;
  final List<PlantModel> plants;

  AllProductsRows({
    required this.context,
    required this.isDarkMode,
    required this.plants,
  });

  void _showDeleteConfirmation(PlantModel plant) {
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
            'Are you sure you want to delete "${plant.name}"?\nThis action cannot be undone.',
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
                context.read<ProductBloc>().add(DeleteProduct(plant.id));

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

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  DataRow? getRow(int index) {
    if (index >= plants.length) return null;

    final plant = plants[index];
    final bool outOfStock = plant.stock <= 0;

    return DataRow2(
      cells: [
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  plant.thumbnailImg,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 46,
                      height: 46,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  plant.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),

        DataCell(
          Align(alignment: Alignment.center, child: Text(plant.category)),
        ),

        DataCell(
          Align(alignment: Alignment.center, child: Text('${plant.stock}')),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(formatDate(plant.restockedAt)),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text('${plant.originalPrice.toInt()} MMK'),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              outOfStock ? 'Out of Stock' : 'Active',
              style: TextStyle(
                color: outOfStock ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
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
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProductScreen(),
                    ),
                  );
                } else if (value == 'delete') {
                  _showDeleteConfirmation(plant);
                } else if (value == 'export') {
                  try {
                    await CsvExportService.exportSinglePlant(plant);
                    if (context.mounted) {
                      toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.flatColored,
                        title: Text('Export Complete'),
                        description: Text('${plant.name} data downloaded.'),
                        alignment: Alignment.bottomCenter,
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      toastification.show(
                        context: context,
                        type: ToastificationType.error,
                        title: Text('Export Failed'),
                        alignment: Alignment.topRight,
                      );
                    }
                  }
                }
                // else if (value == 'export') {
                //   try {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Row(
                //           children: [
                //             const SizedBox(
                //               width: 16,
                //               height: 16,
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //                 strokeWidth: 2,
                //               ),
                //             ),
                //             const SizedBox(width: 12),
                //             Expanded(
                //               child: Text(
                //                 'Preparing export for ${plant.name}...',
                //               ),
                //             ),
                //           ],
                //         ),
                //         behavior: SnackBarBehavior.floating,
                //         width: 340,
                //         duration: const Duration(seconds: 1),
                //       ),
                //     );

                //     await CsvExportService.exportSinglePlant(plant);

                //     if (context.mounted) {
                //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('CSV Exported Successfully!'),
                //           backgroundColor: AppColor.primary,
                //         ),
                //       );
                //     }
                //   } catch (e) {
                //     if (context.mounted) {
                //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('Failed to export: $e'),
                //           backgroundColor: Colors.red,
                //           behavior: SnackBarBehavior.floating,
                //           width: 340,
                //         ),
                //       );
                //     }
                //   }
                // }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => plants.length;

  @override
  int get selectedRowCount => 0;
}
