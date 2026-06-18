import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/paginated_data_table.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/data_table/top_product_rows.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/dashboard_analytics_services.dart';

class TopProductsDataTable extends StatelessWidget {
  const TopProductsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
            'Top Selling Products',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const SizedBox(
                  height: 500,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is OrderError) {
                return SizedBox(
                  height: 500,
                  child: Center(child: Text(state.message)),
                );
              }

              if (state is OrderLoaded) {
                final productStats =
                    DashboardAnalyticsService.generateTopProducts(
                      state.orders
                          .expand((order) => order.items ?? <OrderItemModel>[])
                          .toList(),
                    );

                return SizedBox(
                  height: 410,
                  child: AppPaginatedDataTable(
                    minWidth: 700,
                    // tableHeight: 420,
                    rowsPerPage: 5,
                    isDarkMode: isDarkMode,
                    columns: const [
                      DataColumn2(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text('Product'),
                        ),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text('Stocks'),
                        ),
                      ),
                      DataColumn2(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text('Price'),
                        ),
                      ),
                      DataColumn2(
                        label: Align(
                          alignment: Alignment.center,
                          child: Text('Units Sold'),
                        ),
                      ),
                      DataColumn2(label: Text('Sale Revenues')),
                    ],
                    // Earnings
                    source: TopProductsRows(
                      products: productStats,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
