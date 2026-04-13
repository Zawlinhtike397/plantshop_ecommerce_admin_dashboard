import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/header/app_header.dart';

class MobileLayout extends StatelessWidget {
  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  MobileLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      // ZSideBar(),
      appBar: AppHeader(scaffoldKey: scaffoldKey),
      body: body ?? SizedBox(),
    );
  }
}
