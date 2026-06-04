import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/category_row.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/dashboard_analytics_services.dart';

class TopCategoriesPieChart extends StatelessWidget {
  const TopCategoriesPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrderError) {
          return Center(child: Text(state.message));
        }

        if (state is! OrderLoaded) {
          return const SizedBox();
        }

        final categories = DashboardAnalyticsService.getTopCategories(
          state.orders,
        );

        final totalSales = categories.fold<double>(
          0,
          (sum, item) => sum + item.totalSales,
        );

        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColor.dark1 : Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Selling Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),

              const SizedBox(height: 60),

              SizedBox(
                height: 180,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    startDegreeOffset: -90,
                    sections: categories.map((category) {
                      final percentage =
                          (category.totalSales / totalSales) * 100;

                      return PieChartSectionData(
                        color: category.color,
                        value: percentage,
                        radius: 60,
                        showTitle: true,
                        title: '${percentage.toStringAsFixed(0)} %',
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              ...categories.map(
                (category) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CategoryRow(
                    color: category.color,
                    title: category.category,
                    amount: '${category.totalSales.toStringAsFixed(0)} MMK',
                    soldCount: '${category.soldCount} sold',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
