import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/bloc/stock_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/alert_summary_box.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/widgets/low_stock_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/enums.dart';

class LowStockAlertsSection extends StatefulWidget {
  const LowStockAlertsSection({super.key});

  @override
  State<LowStockAlertsSection> createState() => _LowStockAlertsSectionState();
}

class _LowStockAlertsSectionState extends State<LowStockAlertsSection> {
  PlantDisplayStatus selectedFilter = PlantDisplayStatus.outOfStock;

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
            .where((item) => item.status == PlantDisplayStatus.outOfStock)
            .length;

        final lowCount = items
            .where((item) => item.status == PlantDisplayStatus.low)
            .length;

        final warningCount = items
            .where((item) => item.status == PlantDisplayStatus.warning)
            .length;

        Color activeFilterColor;
        int activeFilterCount;

        switch (selectedFilter) {
          case PlantDisplayStatus.outOfStock:
            activeFilterCount = criticalCount;
            activeFilterColor = PlantDisplayStatus.outOfStock.color;
            break;
          case PlantDisplayStatus.low:
            activeFilterCount = lowCount;
            activeFilterColor = PlantDisplayStatus.low.color;
            break;
          case PlantDisplayStatus.warning:
          default:
            activeFilterCount = warningCount;
            activeFilterColor = PlantDisplayStatus.warning.color;
            break;
        }

        return Container(
          height: 480,
          padding: const EdgeInsets.all(24),
          // margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),,
          decoration: BoxDecoration(
            color: isDarkMode ? AppColor.dark1 : AppColor.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Low Stock Alerts",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  title: PlantDisplayStatus.outOfStock.label,
                                  count: criticalCount,
                                  color: PlantDisplayStatus.outOfStock.color,
                                  isSelected:
                                      selectedFilter ==
                                      PlantDisplayStatus.outOfStock,
                                  onTap: () {
                                    setState(() {
                                      selectedFilter =
                                          PlantDisplayStatus.outOfStock;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(
                                width: itemWidth,
                                child: AlertSummaryBox(
                                  title: PlantDisplayStatus.low.label,
                                  count: lowCount,
                                  color: PlantDisplayStatus.low.color,
                                  isSelected:
                                      selectedFilter == PlantDisplayStatus.low,
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = PlantDisplayStatus.low;
                                    });
                                  },
                                  //  Colors.orange,
                                ),
                              ),

                              SizedBox(
                                width: itemWidth,
                                child: AlertSummaryBox(
                                  title: PlantDisplayStatus.warning.label,
                                  count: warningCount,
                                  color: PlantDisplayStatus.warning.color,
                                  isSelected:
                                      selectedFilter ==
                                      PlantDisplayStatus.warning,
                                  onTap: () {
                                    setState(() {
                                      selectedFilter =
                                          PlantDisplayStatus.warning;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedFilter.label} : $activeFilterCount",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: activeFilterColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (activeFilterCount != 0)
                            TextButton(
                              onPressed: () {},
                              child: Text('See all'),
                            ),
                        ],
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
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: LowStockCard(item: filteredItems.first),
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
