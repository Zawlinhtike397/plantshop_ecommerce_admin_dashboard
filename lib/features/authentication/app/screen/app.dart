import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    router = AppRouter.createRouter(context.read<AppBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AppBloc, AppState>(
              listener: (context, state) {
                if (state is AppUnauthorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Access denied. Admins only.'),
                    ),
                  );
                }
              },
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
