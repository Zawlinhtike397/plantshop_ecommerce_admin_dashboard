import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/bloc/stock_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/alert_summary_box.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/low_stock_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';

class LowStockAlertsSection extends StatefulWidget {
  const LowStockAlertsSection({super.key});

  @override
  State<LowStockAlertsSection> createState() => _LowStockAlertsSectionState();
}

class _LowStockAlertsSectionState extends State<LowStockAlertsSection> {
  String selectedFilter = 'Out of Stock';

  List<LowStockItem> _filter(List<LowStockItem> items) {
    return items.where((e) => e.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is StockLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StockError) {
          return Center(child: Text(state.message));
        }

        if (state is! StockLoaded) {
          return const SizedBox();
        }

        final items = state.items;
        final filteredItems = _filter(items);

        final criticalCount = items
            .where((item) => item.status == "Out of Stock")
            .length;

        final lowCount = items.where((item) => item.status == "Low").length;

        final warningCount = items
            .where((item) => item.status == "Warning")
            .length;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColor.dark1 : AppColor.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Low Stock Alerts",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          const spacing = 16.0;
                          const minItemWidth = 150.0;

                          int itemsPerRow =
                              (constraints.maxWidth / (minItemWidth + spacing))
                                  .floor();

                          if (itemsPerRow < 1) itemsPerRow = 1;

                          final itemWidth =
                              (constraints.maxWidth -
                                  ((itemsPerRow - 1) * spacing)) /
                              itemsPerRow;

                          return Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: [
                              SizedBox(
                                width: itemWidth,
                                child: AlertSummaryBox(
                                  title: "Out of Stock",
                                  count: criticalCount,
                                  color: AppColor.criticalStockColor,
                                  isSelected: selectedFilter == "Out of Stock",
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = "Out of Stock";
                                    });
                                  },
                                ),
                              ),

                              SizedBox(
                                width: itemWidth,
                                child: AlertSummaryBox(
                                  title: "Low",
                                  count: lowCount,
                                  color: AppColor.lowStockColor,
                                  isSelected: selectedFilter == "Low",
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = "Low";
                                    });
                                  },
                                  //  Colors.orange,
                                ),
                              ),

                              SizedBox(
                                width: itemWidth,
                                child: AlertSummaryBox(
                                  title: "Warning",
                                  count: warningCount,
                                  color: AppColor.warningStockColor,
                                  isSelected: selectedFilter == "Warning",
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = "Warning";
                                    });
                                  },
                                  //  Colors.amber,
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      filteredItems.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              child: Center(
                                child: Text(
                                  "No items found",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: LowStockCard(
                                    item: filteredItems[index],
                                  ),
                                );
                              },
                            ),
                    ],
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
