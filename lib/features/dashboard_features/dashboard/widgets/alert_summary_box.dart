import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class AlertSummaryBox extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const AlertSummaryBox({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.chipColor : Colors.transparent,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(18),
        ),
        duration: const Duration(milliseconds: 200),
        child: Row(
          children: [
            CircleAvatar(radius: 5, backgroundColor: color),
            const SizedBox(width: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColor.midGray),
                  //  TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text("$count", style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
