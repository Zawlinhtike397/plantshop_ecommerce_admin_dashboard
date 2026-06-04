import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/categories/model/category_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/model/product_analytic_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class DashboardAnalyticsService {
  static List<CategoryModel> getTopCategories(List<OrderModel> orders) {
    final Map<String, double> revenueMap = {};
    final Map<String, int> soldQuantityMap = {};

    for (final order in orders) {
      for (final item in order.items ?? []) {
        final category = item.plant?.category ?? 'Unknown';

        final total = item.price * item.quantity;

        revenueMap[category] = (revenueMap[category] ?? 0) + total;

        soldQuantityMap[category] =
            ((soldQuantityMap[category] ?? 0) + item.quantity) as int;
      }
    }

    debugPrint('revenueMap: $revenueMap');
    debugPrint('sold Quantity map: $soldQuantityMap');

    final colors = [
      AppColor.colorIndoor,
      AppColor.colorOutdoor,
      AppColor.colorGardening,
      AppColor.colorFlowering,
      AppColor.colorHanging,
    ];

    int colorIndex = 0;

    final categories = revenueMap.entries.map((entry) {
      final model = CategoryModel(
        category: entry.key,
        totalSales: entry.value,
        soldCount: soldQuantityMap[entry.key] ?? 0,
        color: colors[colorIndex % colors.length],
      );

      colorIndex++;

      return model;
    }).toList();

    categories.sort((a, b) => b.totalSales.compareTo(a.totalSales));

    return categories;
  }

  static List<ProductAnalyticModel> generateTopProducts(
    List<OrderItemModel> items,
  ) {
    final Map<int, ProductAnalyticModel> map = {};

    for (final item in items) {
      if (item.plant == null) continue;

      final plantId = item.plantId;

      if (map.containsKey(plantId)) {
        final existing = map[plantId]!;

        map[plantId] = ProductAnalyticModel(
          plant: existing.plant,
          unitSold: existing.unitSold + item.quantity,
          totalRevenue: existing.totalRevenue + item.subtotal,
        );
      } else {
        map[plantId] = ProductAnalyticModel(
          plant: item.plant!,
          unitSold: item.quantity,
          totalRevenue: item.subtotal,
        );
      }
    }

    final result = map.values.toList();

    result.sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));

    return result.take(5).toList();
  }
}
