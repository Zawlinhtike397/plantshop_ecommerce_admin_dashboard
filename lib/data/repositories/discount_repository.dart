import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/model/discount_model.dart';

class DiscountRepository {
  final SupabaseClient _supabase;

  DiscountRepository({SupabaseClient? supabase})
    : _supabase = supabase ?? Supabase.instance.client;

  Future<List<DiscountModel>> getDiscounts() async {
    final response = await _supabase
        .from('discounts')
        .select()
        .order('valid_until', ascending: false);

    return (response as List)
        .map((json) => DiscountModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> createDiscount(DiscountModel discount) async {
    final data = discount.toJson();

    await _supabase.from('discounts').insert(data);
  }

  Future<void> updateDiscount(DiscountModel discount) async {
    final data = discount.toJson();

    await _supabase.from('discounts').update(data).eq('id', discount.id);
  }

  Future<void> deleteDiscount(String id) async {
    await _supabase.from('discounts').delete().eq('id', id);
  }
}
