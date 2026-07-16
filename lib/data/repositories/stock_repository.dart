import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/model/low_stock_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      final status = plant.stockLevelStatus;

      return LowStockItem(
        name: plant.name,
        productId: plant.id.toString(),
        category: plant.category,
        currentStock: plant.stock,
        maxStock: plant.maxStock,
        status: status,
        statusColor: status.color,
        image: plant.thumbnailImg,
        lastRestocked: plant.restockedAt,
      );
    }).toList();
  }

  Future<void> reorderPlant({
    required String plantId,
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
}
