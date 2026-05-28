import 'dart:ui';

class LowStockItem {
  final String name;
  final String productId;
  final String category;
  final int currentStock;
  final int maxStock;
  final String status;
  final Color statusColor;
  final String image;
  final DateTime? lastRestocked;

  LowStockItem({
    required this.name,
    required this.productId,
    required this.category,
    required this.currentStock,
    required this.maxStock,
    required this.status,
    required this.statusColor,
    required this.image,
    required this.lastRestocked,
  });

  String get formattedRestockedAt {
    if (lastRestocked == null) return '';

    final date = lastRestocked!;

    return "${date.day}/${date.month}/${date.year}";
  }

  double get stockPercentage => currentStock / maxStock;
}
