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
              order_items (*, plants (*)), Users(*)
            ''')
        .order('created_at', ascending: false);

    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    final response = await supabase
        .from('orders')
        .update({'status': status})
        .eq('id', orderId)
        .neq('status', 'delivered')
        .neq('status', 'cancelled')
        .select('id, status');

    if (response.isEmpty) {
      throw Exception("Something went wrong while updating");
    }
  }
}
