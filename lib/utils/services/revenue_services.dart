import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/model/revenue_data_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';

class RevenueService {
  static List<RevenueDataModel> getWeeklyRevenue(List<OrderModel> orders) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final revenueMap = List<double>.filled(7, 0);

    for (var order in orders) {
      final date = order.createdAt;
      if (date == null) continue;

      final index = date.weekday - 1;
      revenueMap[index] += order.totalAmount;
    }

    return List.generate(7, (index) {
      return RevenueDataModel(label: days[index], amount: revenueMap[index]);
    });
  }

  static List<RevenueDataModel> getMonthlyRevenue(List<OrderModel> orders) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final revenue = List<double>.filled(12, 0);

    for (var order in orders) {
      final date = order.createdAt;
      if (date == null) continue;

      revenue[date.month - 1] += order.totalAmount;
    }

    return List.generate(12, (i) {
      return RevenueDataModel(label: months[i], amount: revenue[i]);
    });
  }

  static List<RevenueDataModel> getYearlyRevenue(List<OrderModel> orders) {
    final currentYear = DateTime.now().year;

    final revenueMap = {
      for (int y = currentYear - 6; y <= currentYear; y++) y: 0.0,
    };

    for (var order in orders) {
      final date = order.createdAt;
      if (date == null) continue;

      if (revenueMap.containsKey(date.year)) {
        revenueMap[date.year] = revenueMap[date.year]! + order.totalAmount;
      }
    }

    final sortedKeys = revenueMap.keys.toList()..sort();

    return sortedKeys.map((year) {
      return RevenueDataModel(
        label: year.toString(),
        amount: revenueMap[year]!,
      );
    }).toList();
  }
}
