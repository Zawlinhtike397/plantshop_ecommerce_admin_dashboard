import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/authentication_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/login_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/screen/dashboard_screen.dart';

import 'go_router_refresh_stream.dart';

class AppRouter {
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static final authRepository = AuthenticationRepository();

  static GoRouter createRouter(AppBloc appBloc) {
    return GoRouter(
      initialLocation: '/login',

      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: (context, state) {
        final appState = context.read<AppBloc>().state;
        // appBloc.state;

        final isLoggingIn = state.uri.path == '/login';

        if (appState is AppUnauthenticated) {
          return isLoggingIn ? null : '/login';
        }

        if (appState is AppUnauthorized) {
          return '/login';
        }

        if (appState is AppAuthenticated) {
          return isLoggingIn ? '/dashboard' : null;
        }

        return null;
      },

      routes: [
        GoRoute(
          name: login,
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          name: dashboard,
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
      ],
    );
  }
}
