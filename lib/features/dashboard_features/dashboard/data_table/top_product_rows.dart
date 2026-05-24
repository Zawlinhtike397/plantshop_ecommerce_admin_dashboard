import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/images/custom_circular_image.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/model/product_analytic_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/enums.dart';

class TopProductsRows extends DataTableSource {
  final List<ProductAnalyticModel> products;

  TopProductsRows({required this.products});

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;

    final item = products[index];

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(8),
                child: AppCircularImage(
                  padding: 0.0,
                  imageType: ImageType.network,
                  image: item.plant.thumbnailImg,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  item.plant.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(item.plant.stock.toString()),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(item.plant.originalPrice.toStringAsFixed(0)),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(item.unitSold.toString()),
          ),
        ),

        DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(
              ' ${item.totalRevenue.toStringAsFixed(0)} MMK',
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
