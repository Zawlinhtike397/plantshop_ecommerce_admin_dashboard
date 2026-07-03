import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class CustomDropdown extends StatelessWidget {
  final bool isDarkMode;
  final String value;
  final List<String> itemsValue;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.isDarkMode,
    required this.value,
    required this.itemsValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        dropdownColor: isDarkMode ? AppColor.dark1 : AppColor.sidebarBackground,
        items: [
          for (var i = 0; i < itemsValue.length; i++)
            DropdownMenuItem(value: itemsValue[i], child: Text(itemsValue[i])),
        ],
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 13,
        ),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, size: 20),
      ),
    );
  }
}
