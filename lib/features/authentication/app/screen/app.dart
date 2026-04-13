import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/login_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppAuthenticated) {
            return const DashboardScreen();
          } else if (state is AppUnauthenticated) {
            return LoginScreen();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
