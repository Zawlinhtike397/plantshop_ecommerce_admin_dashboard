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
      final String sanitizedFileName = fileName.replaceAll(
        RegExp(r'[^a-zA-Z0-9.\-]'),
        '_',
      );
      final path = 'plants/$sanitizedFileName';
      await supabase.storage
          .from('plants')
          .updateBinary(
            path,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );
      return supabase.storage.from('plants').getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> updateProduct(PlantModel plant) async {
    try {
      final plantData = plant.toJson();

      await supabase.from('plants').update(plantData).eq('id', plant.id);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await supabase
          .from('plants')
          .select('thumbnailImg, imageUrl')
          .eq('id', id)
          .single();

      final String? thumbnailImgUrl = response['thumbnailImg'];
      final List<dynamic>? additionalImages = response['imageUrl'];

      await supabase.from('plants').delete().eq('id', id);

      if (thumbnailImgUrl != null && thumbnailImgUrl.isNotEmpty) {
        await deleteProductImage(thumbnailImgUrl);
      }

      if (additionalImages != null && additionalImages.isNotEmpty) {
        for (final imageUrl in additionalImages) {
          if (imageUrl.toString().isNotEmpty) {
            await deleteProductImage(imageUrl.toString());
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to delete product from database: $e');
    }
  }

  Future<void> deleteProductImage(String fullImageUrl) async {
    try {
      if (fullImageUrl.isEmpty) return;

      final uri = Uri.parse(fullImageUrl);
      final pathSegments = uri.pathSegments;

      final bucketIndex = pathSegments.indexOf('plants');
      if (bucketIndex != -1 && bucketIndex < pathSegments.length - 1) {
        final filePath = pathSegments.sublist(bucketIndex + 1).join('/');

        await supabase.storage.from('plants').remove([filePath]);
      }
    } catch (e) {
      print('Failed to delete old image from storage: $e');
    }
  }
}
