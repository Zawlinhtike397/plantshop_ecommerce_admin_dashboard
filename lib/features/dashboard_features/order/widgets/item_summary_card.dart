import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/model/order_item_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_row.dart';

class ItemSummaryCard extends StatelessWidget {
  final List<OrderItemModel> items;

  const ItemSummaryCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Item Summary',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                const SizedBox(width: 60),
                const Expanded(child: SizedBox()),
                const SizedBox(
                  width: 80,
                  child: Text(
                    'Qty',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 100,
                  child: Text(
                    'Price',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 100,
                  child: Text(
                    'Total Price',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ItemRow(
                    name: item.plant?.name ?? 'Unknown Plant',
                    qty: 'x${item.quantity}',
                    price: '${item.price} MMK',
                    total: '${item.subtotal} MMK',
                    imageUrl: item.plant?.thumbnailImg,
                  ),
                ),
              )
              .toList(),
          if (items.isEmpty) const Center(child: Text("No items found.")),
        ],
      ),
    );
  }
}
