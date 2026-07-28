import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'ID  ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '123456',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 32),
        Text(
          'Order created  ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '30/07/2024',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
        const Spacer(),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {},
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Pending',
              child: Text('Mark as Pending', style: TextStyle(fontSize: 12)),
            ),
            const PopupMenuItem<String>(
              value: 'Processing',
              child: Text(
                'Marked as Processing',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Shipping',
              child: Text('Marked as Shipping', style: TextStyle(fontSize: 12)),
            ),
            const PopupMenuItem<String>(
              value: 'Delivered',
              child: Text(
                'Marked as Delivered',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Cancel',
              child: Text('Cancel your plant', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }
}
