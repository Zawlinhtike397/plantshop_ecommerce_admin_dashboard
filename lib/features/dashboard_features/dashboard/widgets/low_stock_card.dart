import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/bloc/stock_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class LowStockCard extends StatelessWidget {
  final LowStockItem item;

  const LowStockCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double progress = item.currentStock / item.maxStock;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 450;
        final bool isExtraSmall = constraints.maxWidth < 300;

        final Widget stockProgressBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stock level",
              style: TextStyle(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: isDarkMode
                    ? Colors.grey.shade800
                    : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(item.statusColor),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item.currentStock}",
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
                Text(
                  "${item.maxStock}",
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        );

        final Widget stockActionBlock = Column(
          crossAxisAlignment: isSmallScreen
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              "${item.currentStock}/${item.maxStock} pots",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () {
                context.read<StockBloc>().add(
                  ReorderPlant(
                    plantId: int.parse(item.productId),
                    currentStock: item.currentStock,
                    maxStock: item.maxStock,
                  ),
                );
              },
              icon: const Icon(Icons.arrow_outward, size: 18),
              label: const Text("Reorder"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );

        final Widget detailsContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Text(item.name, style: Theme.of(context).textTheme.titleLarge),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: item.statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: item.statusColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.status,
                        style: TextStyle(
                          color: item.statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Product ID: ${item.productId}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),

            Text(
              "Category: ${item.category}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15),

            isExtraSmall
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      stockProgressBlock,
                      const SizedBox(height: 20),
                      stockActionBlock,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: stockProgressBlock),
                      const SizedBox(width: 24),
                      stockActionBlock,
                    ],
                  ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 5),

            Text(
              item.formattedRestockedAt.isEmpty
                  ? "Item is not restocked yet"
                  : "Last restocked:     ${item.formattedRestockedAt}",
              style: TextStyle(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
          ],
        );

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDarkMode ? Colors.white10 : AppColor.borderColor,
            ),
            color: isDarkMode
                ? const Color(0xFF262626)
                : AppColor.sidebarBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.image,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),
                    detailsContent,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: detailsContent),
                  ],
                ),
        );
      },
    );
  }
}
