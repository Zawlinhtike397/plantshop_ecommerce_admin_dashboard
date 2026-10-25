import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

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
              margin: const EdgeInsets.only(top: 3),
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
                height: 54,
                color: isCompleted ? AppColor.primary : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            margin: isLast
                ? const EdgeInsets.only(bottom: 20.0)
                : EdgeInsets.zero,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isCompleted ? AppColor.primary : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
