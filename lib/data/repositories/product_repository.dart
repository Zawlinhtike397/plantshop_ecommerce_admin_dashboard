import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<PlantModel>> getAllProducts() async {
    final response = await supabase
        .from('plants')
        .select()
        .order('name', ascending: true);

    return (response as List).map((e) => PlantModel.fromJson(e)).toList();
  }

  Future<void> deleteProduct(int id) async {
    try {
      await supabase
          .from('plants') // Replace with your actual table name
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete product from database: $e');
    }
  }
}
