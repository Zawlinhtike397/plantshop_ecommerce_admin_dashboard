import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/model/plant_model.dart';

class OrderItemModel {
  final String? id;
  final String orderId;
  final String plantId;
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
      plantId: json['plant_id']?.toString() ?? '0',
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      plant: json['plants'] != null
          ? PlantModel.fromJson(json['plants'])
          : null,
    );
  }

  double get subtotal => price * quantity;
}
