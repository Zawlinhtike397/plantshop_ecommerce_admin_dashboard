import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final bool isLast;

  const TimelineWidget({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? const Color(0xFF4CAF50)
                    : Colors.grey.shade300,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: isCompleted
                    ? const Color(0xFF4CAF50)
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              text,
              style: TextStyle(
                color: isCompleted
                    ? Colors.grey.shade800
                    : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
