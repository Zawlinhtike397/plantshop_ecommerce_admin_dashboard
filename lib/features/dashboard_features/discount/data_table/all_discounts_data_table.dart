import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/paginated_data_table.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/data_table/table_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/bloc/discount_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/data_table/all_discounts_rows.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/screen/widgets/add_edit_discount_dialog.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';

class AllDiscountsDataTable extends StatelessWidget {
  const AllDiscountsDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.watch<ThemeCubit>().state.isDarkMode ||
        Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColor.dark1 : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            TableHeader(
              isDarkMode: isDarkMode,
              hintText: 'Search specific discounts',
              buttonText: 'Add New',
              haveActionBtn: true,
              onSearchChanged: (query) {
                context.read<DiscountBloc>().add(SearchDiscounts(query));
              },
              onActionPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AddEditDiscountDialog();
                  },
                );
              },
            ),
            const SizedBox(height: 14),
            Expanded(
              child: BlocBuilder<DiscountBloc, DiscountState>(
                builder: (context, state) {
                  if (state is DiscountLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is DiscountError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is DiscountLoaded) {
                    if (state.filteredDiscounts.isEmpty) {
                      return Center(
                        child: Text(
                          state.discounts.isEmpty
                              ? 'No discounts available yet.'
                              : 'No discounts match your search.',
                        ),
                      );
                    }

                    return AppPaginatedDataTable(
                      key: ValueKey(state.filteredDiscounts.length),
                      minWidth: 1040,
                      columns: const [
                        DataColumn2(label: Text('Code'), size: ColumnSize.S),
                        DataColumn2(
                          label: Text('Description'),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(label: Center(child: Text('Percentage'))),
                        DataColumn2(label: Center(child: Text('Min Amount'))),
                        DataColumn2(label: Center(child: Text('IsActive'))),
                        DataColumn2(
                          label: Center(child: Text('FirstTimeOnly')),
                        ),
                        DataColumn2(
                          label: Center(child: Text('Rules')),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(label: Center(child: Text('Expired Date'))),
                        DataColumn2(
                          label: Center(child: Text('Actions')),
                          size: ColumnSize.S,
                        ),
                      ],
                      source: AllDiscountsRows(
                        context: context,
                        discounts: state.filteredDiscounts,
                        isDarkMode: isDarkMode,
                      ),
                      rowsPerPage: 5,
                      isDarkMode: isDarkMode,
                      dataRowHeight: 70,
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
