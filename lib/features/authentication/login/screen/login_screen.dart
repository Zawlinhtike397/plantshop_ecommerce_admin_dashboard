import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/responsive/login_screen_desktop_tablet.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/responsive/login_screen_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      useLayout: false,
      desktop: LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
