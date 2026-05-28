import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/stock_status_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class StockRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<LowStockItem>> getLowStockItems() async {
    final response = await supabase
        .from('plants')
        .select()
        .lte('stock', 10)
        .order('stock', ascending: true);

    final plants = (response as List)
        .map((e) => PlantModel.fromJson(e))
        .toList();

    return plants.map((plant) {
      final status = _getStatus(plant.stock);

      return LowStockItem(
        name: plant.name,
        productId: plant.id.toString(),
        category: plant.category,
        currentStock: plant.stock,
        maxStock: plant.maxStock,
        status: status.label,
        statusColor: status.color,
        image: plant.thumbnailImg,
        lastRestocked: plant.restockedAt,
      );
    }).toList();
  }

  Future<void> reorderPlant({
    required int plantId,
    required int currentStock,
    required int maxStock,
  }) async {
    final reorderAmount = maxStock - currentStock;

    final updatedStock = currentStock + reorderAmount;

    await supabase
        .from('plants')
        .update({
          'stock': updatedStock,
          'lastRestockedAt': DateTime.now().toIso8601String(),
        })
        .eq('id', plantId);
  }

  StockStatus _getStatus(int stock) {
    if (stock <= 0) {
      return StockStatus("Out of Stock", Colors.red);
    }

    if (stock <= 5) {
      return StockStatus("Low", const Color.fromARGB(255, 237, 131, 93));
    }

    return StockStatus("Warning", const Color(0xFFEAB308));
  }
}
