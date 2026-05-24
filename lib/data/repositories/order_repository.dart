import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<OrderModel>> getOrders() async {
    final response = await supabase
        .from('orders')
        .select('''
              *,
              address:address_id (*),
              order_items (*, plants (*))
            ''')
        .order('created_at', ascending: false);

    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }
}
