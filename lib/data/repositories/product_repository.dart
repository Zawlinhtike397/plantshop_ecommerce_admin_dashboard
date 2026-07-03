import 'dart:typed_data';

import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<PlantModel>> getAllProducts() async {
    final response = await supabase
        .from('plants')
        .select()
        .order('name', ascending: true);

    return response.map((e) => PlantModel.fromJson(e)).toList();
  }

  Future<void> addProduct(PlantModel plant) async {
    try {
      final plantData = plant.toJson();
      // plantData.remove('id');

      await supabase.from('plants').insert(plantData);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<String> uploadProductImage(
    Uint8List fileBytes,
    String fileName,
  ) async {
    try {
      final path = 'plants/$fileName';
      await supabase.storage
          .from('plants')
          .updateBinary(
            path,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );
      // return supabase.storage.from('plants_media').getPublicUrl(path);
      return supabase.storage.from('plants').getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await supabase.from('plants').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete product from database: $e');
    }
  }
}
