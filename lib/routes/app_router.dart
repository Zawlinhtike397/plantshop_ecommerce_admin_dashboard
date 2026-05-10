import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/authentication_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/login_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/categories/screen/category_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/customer/screen/customer_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/dashboard/screen/dashboard_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/screen/discount_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/screen/order_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/product_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/profile/screen/profile_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/settings/screen/setting_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/wrapper/sidebar_sync_wrapper.dart';

import 'go_router_refresh_stream.dart';

class AppRouter {
  static final authRepository = AuthenticationRepository();

  static GoRouter createRouter(AppBloc appBloc) {
    return GoRouter(
      initialLocation: AppRoutes.loginPath,
      //  '/login',
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      routes: [
        GoRoute(
          // name: AppRoutes.login,
          path: AppRoutes.loginPath,
          builder: (context, state) => LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return SidebarSyncWrapper(child: child);
          },
          routes: [
            GoRoute(
              // name: AppRoutes.dashboard,
              path: AppRoutes.dashboardPath,
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              // name: AppRoutes.products,
              path: AppRoutes.productsPath,
              builder: (context, state) => const ProductScreen(),
            ),
            GoRoute(
              // name: AppRoutes.orders,
              path: AppRoutes.ordersPath,
              builder: (context, state) => const OrderScreen(),
            ),
            GoRoute(
              // name: AppRoutes.customers,
              path: AppRoutes.customersPath,
              builder: (context, state) => const CustomerScreen(),
            ),
            GoRoute(
              // name: AppRoutes.discountCupons,
              path: AppRoutes.discountCuponsPath,
              builder: (context, state) => const DiscountScreen(),
            ),
            GoRoute(
              // name: AppRoutes.categories,
              path: AppRoutes.categoriesPath,
              builder: (context, state) => const CategoriesScreen(),
            ),
            GoRoute(
              // name: AppRoutes.categories,
              path: AppRoutes.settingsPath,
              builder: (context, state) => const SettingScreen(),
            ),
            GoRoute(
              path: AppRoutes.profilePath,
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final appState = context.read<AppBloc>().state;
        // appBloc.state;

        final isLoggingIn = state.uri.path == AppRoutes.loginPath;
        // '/login';

        if (appState is AppUnauthenticated) {
          return isLoggingIn ? null : AppRoutes.loginPath;
        }

        if (appState is AppUnauthorized) {
          return AppRoutes.loginPath;
        }

        if (appState is AppAuthenticated) {
          return isLoggingIn ? AppRoutes.dashboardPath : null;
        }
        return null;
      },
    );
  }
}
