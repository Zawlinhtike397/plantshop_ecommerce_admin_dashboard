import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final String name;
  final String qty;
  final String price;
  final String total;
  final String? imageUrl;

  const ItemRow({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
    required this.total,
    this.imageUrl,
  });

  Widget _buildPlaceholder() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.eco, color: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? Image.network(
                  imageUrl!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholder(),
                )
              : _buildPlaceholder(),
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
