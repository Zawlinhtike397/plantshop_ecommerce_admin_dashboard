import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/header/app_header.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/custom_sidebar.dart';

class TabletLayout extends StatelessWidget {
  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TabletLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: ZSideBar(),
      appBar: AppHeader(scaffoldKey: scaffoldKey),
      body: body ?? SizedBox(),
    );
  }
}
