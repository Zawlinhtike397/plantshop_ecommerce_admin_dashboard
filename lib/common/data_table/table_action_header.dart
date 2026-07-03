import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class TableActionHeader extends StatelessWidget {
  final bool isDarkMode;
  final String hintText;
  final String buttonText;
  final Function(String)? onSearchChanged;

  const TableActionHeader({
    super.key,
    required this.isDarkMode,
    required this.hintText,
    required this.buttonText,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sharedInputDecoration = InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: isDarkMode ? AppColor.dark2 : AppColor.sidebarBackground,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
    );

    Widget buildAddButton({
      required String text,
      required EdgeInsetsGeometry padding,
    }) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttonPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: padding,
        ),
        onPressed: () {
          context.go(AppRoutes.addProduct);
        },
        child: Text(text, style: const TextStyle(color: Colors.white)),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobileWidth = constraints.maxWidth < 600;

        if (isMobileWidth) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: sharedInputDecoration,
                  onChanged: onSearchChanged,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  child: buildAddButton(
                    text: buttonText,
                    padding: const EdgeInsets.only(top: 22.0, bottom: 22.0),
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 420,
              height: 46,
              child: TextField(
                decoration: sharedInputDecoration,
                onChanged: onSearchChanged,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 46,
              child: buildAddButton(
                text: 'Add New Plant',
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 22.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
