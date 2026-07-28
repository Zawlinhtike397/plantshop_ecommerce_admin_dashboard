import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/base_card.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/widgets/item_row.dart';

class ItemSummaryCard extends StatelessWidget {
  const ItemSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: 'Item Summary',
      child: Column(
        children: [
          // Table Header
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                const SizedBox(width: 60), // Space for image
                const Expanded(child: SizedBox()), // Space for name
                const SizedBox(
                  width: 80,
                  child: Text(
                    'Qty',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 100,
                  child: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 100,
                  child: Text(
                    'Total Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Table Rows
          ItemRow(
            name: 'Jade Plant',
            qty: 'x2',
            price: '20000MMK',
            total: '40000MMK',
          ),
          const SizedBox(height: 16),
          ItemRow(
            name: 'Jade Plant',
            qty: 'x2',
            price: '20000MMK',
            total: '40000MMK',
          ),
          const SizedBox(height: 16),
          ItemRow(
            name: 'Jade Plant',
            qty: 'x2',
            price: '20000MMK',
            total: '40000MMK',
          ),
        ],
      ),
    );
  }
}
