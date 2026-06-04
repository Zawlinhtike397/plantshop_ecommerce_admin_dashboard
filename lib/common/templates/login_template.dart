import 'package:flutter/material.dart';

class LoginTemplate extends StatelessWidget {
  final Widget child;
  const LoginTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          width: 550,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 24.0,
                bottom: 24.0,
                right: 24.0,
                top: 24.0,
              ),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
