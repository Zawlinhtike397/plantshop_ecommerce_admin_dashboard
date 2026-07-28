import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final String name;
  final String qty;
  final String price;
  final String total;

  const ItemRow({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.eco, color: Colors.green),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(name, style: TextStyle(color: Colors.grey.shade700)),
        ),
        SizedBox(
          width: 80,
          child: Text(qty, style: TextStyle(color: Colors.grey.shade600)),
        ),
        SizedBox(
          width: 100,
          child: Text(price, style: TextStyle(color: Colors.grey.shade600)),
        ),
        SizedBox(
          width: 100,
          child: Text(total, style: TextStyle(color: Colors.grey.shade600)),
        ),
      ],
    );
  }
}
