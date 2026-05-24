import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/custom_sidebar.dart';

class DesktopLayout extends StatelessWidget {
  final Widget? body;
  const DesktopLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 260, child: ZSideBar()),
          Expanded(
            child: Column(
              children: [
                // header
                // AppHeader(),
                Expanded(child: body ?? SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
