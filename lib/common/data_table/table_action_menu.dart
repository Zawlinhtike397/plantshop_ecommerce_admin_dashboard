import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class TableActionMenu extends StatelessWidget {
  final bool isDarkMode;
  final List<PopupMenuEntry<String>> items;
  final ValueChanged<String> onSelected;

  const TableActionMenu({
    super.key,
    required this.isDarkMode,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_horiz,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        color: isDarkMode ? AppColor.dark2 : AppColor.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isDarkMode
                ? AppColor.dark3
                : AppColor.borderColor.withValues(alpha: 0.5),
          ),
        ),
        onSelected: onSelected,
        itemBuilder: (_) => items,
      ),
    );
  }
}
