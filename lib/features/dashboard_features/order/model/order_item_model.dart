import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class OrderItemModel {
  final String? id;
  final String orderId;
  final int plantId;
  final int quantity;
  final double price;
  PlantModel? plant;

  OrderItemModel({
    this.id,
    required this.orderId,
    required this.plantId,
    required this.quantity,
    required this.price,
    this.plant,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'order_id': orderId,
      'plant_id': plantId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id']?.toString(),
      orderId: json['order_id']?.toString() ?? '',
      plantId: (json['plant_id'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      plant: json['plants'] != null
          ? PlantModel.fromJson(json['plants'])
          : null,
    );
  }

  double get subtotal => price * quantity;
}
