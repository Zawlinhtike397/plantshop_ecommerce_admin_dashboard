import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/widgets/login_form.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/widgets/login_header.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [LoginHeader(), LoginForm()]),
          ),
        ),
      ),
    );
  }
}
