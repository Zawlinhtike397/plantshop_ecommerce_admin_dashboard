import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/paginated_data_table.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/table_action_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/data_table.dart/all_products_rows.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';

class AllProductsDataTable extends StatelessWidget {
  const AllProductsDataTable({super.key});

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
              hintText: 'Search specific plants',
              buttonText: 'Add Plant',
              onSearchChanged: (query) {
                context.read<ProductBloc>().add(SearchProducts(query));
              },
            ),
            const SizedBox(height: 24),

            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.primary),
                    );
                  } else if (state is ProductError) {
                    return Center(
                      child: Text(
                        'Error loading products: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    if (state.filteredProducts.isEmpty) {
                      return const Center(
                        child: Text('No plants match your search.'),
                      );
                    }

                    return AppPaginatedDataTable(
                      key: ValueKey(state.filteredProducts.length),
                      minWidth: 700,
                      columns: const [
                        DataColumn2(label: Text('Name'), size: ColumnSize.L),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Category'),
                          ),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Stock'),
                          ),
                        ),
                        DataColumn2(
                          label: Align(
                            alignment: Alignment.center,
                            child: Text('Restock Date'),
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
                      source: AllProductsRows(
                        context: context,
                        isDarkMode: isDarkMode,
                        plants: state.filteredProducts,
                      ),
                      rowsPerPage: 5,
                      isDarkMode: isDarkMode,
                    );
                  }
                  return const Center(
                    child: Text('Initialize fetching products...'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
