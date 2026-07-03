import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/model/revenue_data_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/services/revenue_services.dart';

class SalesRevenueChart extends StatefulWidget {
  final List<OrderModel> orders;
  const SalesRevenueChart({super.key, required this.orders});

  @override
  State<SalesRevenueChart> createState() => _SalesRevenueChartState();
}

class _SalesRevenueChartState extends State<SalesRevenueChart> {
  String selectedFilter = 'Monthly';
  final List<String> filters = ['Weekly', 'Monthly', 'Yearly'];
  final ScrollController _chartScrollController = ScrollController();

  @override
  dispose() {
    _chartScrollController.dispose();
    super.dispose();
  }

  String formatMMK(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(0)}M';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    }

    return value.toStringAsFixed(0);
  }

  List<RevenueDataModel> get revenueData {
    switch (selectedFilter) {
      case 'Weekly':
        return RevenueService.getWeeklyRevenue(widget.orders);
      case 'Yearly':
        return RevenueService.getYearlyRevenue(widget.orders);
      default:
        return RevenueService.getMonthlyRevenue(widget.orders);
    }
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 30,
          borderRadius: BorderRadius.circular(4),
          color: AppColor.buttonPrimary,
        ),
      ],
    );
  }

  List<String> get bottomTitles {
    return revenueData.map((e) => e.label).toList();
  }

  double get maxY {
    if (revenueData.isEmpty) return 1000;

    final maxValue = revenueData
        .map((e) => e.amount)
        .reduce((a, b) => a > b ? a : b);

    if (maxValue <= 0) {
      return 1000;
    }

    return maxValue * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.dark1 : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales Revenue',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColor.dark2 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    borderRadius: BorderRadius.circular(12),
                    items: filters.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 350,
            child: revenueData.isEmpty
                ? const Center(
                    child: Text(
                      'No revenue records available for this period.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final double chartCalculatedWidth =
                          revenueData.length * 70;
                      final double finalWidth =
                          chartCalculatedWidth > constraints.maxWidth
                          ? chartCalculatedWidth
                          : constraints.maxWidth;

                      return Scrollbar(
                        controller: _chartScrollController,
                        thickness: 6.0,
                        radius: const Radius.circular(10),
                        interactive: true,
                        child: SingleChildScrollView(
                          controller: _chartScrollController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: finalWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                              ),
                              child: BarChart(
                                duration: Duration.zero,
                                BarChartData(
                                  maxY: maxY,
                                  alignment: BarChartAlignment.spaceAround,
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    horizontalInterval: maxY <= 0
                                        ? 1
                                        : maxY / 5,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey.shade300,
                                        strokeWidth: 1,
                                        dashArray: [5, 5],
                                      );
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.symmetric(
                                      vertical: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                      horizontal: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                        reservedSize: 0,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 60,
                                        showTitles: true,
                                        interval: maxY / 5,
                                        getTitlesWidget: (value, meta) {
                                          return SideTitleWidget(
                                            meta: meta,
                                            space: 8,
                                            child: Text(
                                              meta.formattedValue,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 20,
                                        getTitlesWidget: (value, meta) {
                                          final index = value.toInt();

                                          if (index < 0 ||
                                              index >= bottomTitles.length) {
                                            return const SizedBox();
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2,
                                            ),
                                            child: Text(
                                              bottomTitles[index],
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barGroups: revenueData.asMap().entries.map((
                                    entry,
                                  ) {
                                    final index = entry.key;
                                    final data = entry.value;

                                    return makeGroupData(index, data.amount);
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
