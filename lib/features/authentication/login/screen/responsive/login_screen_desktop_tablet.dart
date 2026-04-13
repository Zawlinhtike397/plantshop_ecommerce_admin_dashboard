import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/login_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/widgets/login_form.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/widgets/login_header.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(child: Column(children: [LoginHeader(), LoginForm()]));
  }
}
