import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/custom_sidebar.dart';

class MobileLayout extends StatelessWidget {
  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  MobileLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: ZSideBar(),
      // ZSideBar(),
      appBar: AppBar(),
      // AppHeader(scaffoldKey: scaffoldKey),
      body: body ?? SizedBox(),
    );
  }
}
