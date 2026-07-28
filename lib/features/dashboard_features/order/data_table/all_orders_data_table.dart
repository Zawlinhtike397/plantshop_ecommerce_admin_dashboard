import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/paginated_data_table.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/table_action_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/data_table/all_orders_row.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';

class AllOrdersDataTable extends StatelessWidget {
  const AllOrdersDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.watch<ThemeCubit>().state.isDarkMode ||
        Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColor.dark1 : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),

        child: Column(
          children: [
            TableActionHeader(
              isDarkMode: isDarkMode,
              hintText: 'Search specific orders',
              buttonText: 'Add Order',
              onSearchChanged: (query) {},
            ),
            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderError) {
                    return Center(child: Text(state.message));
                  } else if (state is OrderLoaded) {
                    return AppPaginatedDataTable(
                      // key: ValueKey(state.filteredProducts.length),
                      minWidth: 700,
                      columns: const [
                        DataColumn2(
                          label: Text('Order ID(In short form)'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Customer'),
                          ),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Items'),
                          ),
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Order Date'),
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
                            child: Text('Status'),
                          ),
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Actions'),
                          ),
                          size: ColumnSize.S,
                        ),
                      ],
                      source: AllOrdersRows(
                        context: context,
                        isDarkMode: isDarkMode,
                        orders: state.orders,
                      ),
                      rowsPerPage: 5,
                      isDarkMode: isDarkMode,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
