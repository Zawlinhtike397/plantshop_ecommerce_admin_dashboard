import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/customer/model/address_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_item_model.dart';

class OrderModel {
  final String? id;
  final String userId;
  final String addressId;
  final String paymentMethod;
  final double totalAmount;
  final double subTotal;
  final double discount;
  final double deliveryFee;
  final String? status;
  final DateTime? createdAt;
  List<OrderItemModel>? items;
  AddressModel? address;

  OrderModel({
    this.id,
    required this.userId,
    required this.addressId,
    required this.paymentMethod,
    required this.totalAmount,
    required this.subTotal,
    required this.discount,
    required this.deliveryFee,
    this.status,
    this.createdAt,
    this.items,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'address_id': addressId,
      'payment_method': paymentMethod,
      'total': totalAmount,
      'subtotal': subTotal,
      'discount': discount,
      'delivery_fee': deliveryFee,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['order_items'] as List? ?? [];
    return OrderModel(
      id: json['id']?.toString(),
      userId: json['user_id']?.toString() ?? '',
      addressId: json['address_id']?.toString() ?? '',
      paymentMethod: json['payment_method']?.toString() ?? '',
      totalAmount: (json['total'] as num).toDouble() ?? 0.0,
      subTotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      status: json['status']?.toString() ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      items: itemsJson.map((e) => OrderItemModel.fromJson(e)).toList(),
      address: json['address'] != null
          ? AddressModel.fromMap(json['address'])
          // : AddressModel.empty(),
          : null,
    );
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    String? addressId,
    String? paymentMethod,
    double? totalAmount,
    double? subTotal,
    double? discount,
    double? deliveryFee,
    String? status,
    DateTime? createdAt,
    List<OrderItemModel>? items,
    AddressModel? address,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      addressId: addressId ?? this.addressId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      subTotal: subTotal ?? this.subTotal,
      discount: discount ?? this.discount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      address: address ?? this.address,
    );
  }
}
