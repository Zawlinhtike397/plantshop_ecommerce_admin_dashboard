import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/data_table/top_products_data_table.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/low_stock_alert_section.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/overall_data_grid.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/revenue_chart_section.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/top_categories_pie_chart.dart';

class DashboardScreenTablet extends StatelessWidget {
  const DashboardScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 25.0,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              OverallDataGrid(),
              Row(
                spacing: 15.0,
                children: [
                  Expanded(flex: 3, child: RevenueChartSection()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      width: double.infinity,
                      height: 410,
                      child: LowStockAlertsSection(),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  Expanded(flex: 2, child: TopCategoriesPieChart()),
                  Expanded(flex: 3, child: TopProductsDataTable()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
