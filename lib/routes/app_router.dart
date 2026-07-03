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
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/add_product_screen.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/screen/edit_product_screen.dart';
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
      initialLocation: AppRoutes.login,
      //  '/login',
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      routes: [
        GoRoute(
          // name: AppRoutes.login,
          path: AppRoutes.login,
          builder: (context, state) => LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) {
            return SidebarSyncWrapper(child: child);
          },
          routes: [
            GoRoute(
              // name: AppRoutes.dashboard,
              path: AppRoutes.dashboard,
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              // name: AppRoutes.products,
              path: AppRoutes.products,
              builder: (context, state) => const ProductScreen(),
            ),
            GoRoute(
              // name: AppRoutes.orders,
              path: AppRoutes.orders,
              builder: (context, state) => const OrderScreen(),
            ),
            GoRoute(
              // name: AppRoutes.customers,
              path: AppRoutes.customers,
              builder: (context, state) => const CustomerScreen(),
            ),
            GoRoute(
              // name: AppRoutes.discountCupons,
              path: AppRoutes.discountCupons,
              builder: (context, state) => const DiscountScreen(),
            ),
            GoRoute(
              // name: AppRoutes.categories,
              path: AppRoutes.categories,
              builder: (context, state) => const CategoriesScreen(),
            ),
            GoRoute(
              // name: AppRoutes.categories,
              path: AppRoutes.settings,
              builder: (context, state) => const SettingScreen(),
            ),
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => ProfileScreen(),
            ),
            GoRoute(
              path: AppRoutes.addProduct,
              builder: (context, state) => AddProductScreen(),
            ),
            GoRoute(
              path: AppRoutes.editProduct,
              builder: (context, state) => EditProductScreen(),
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final appState = context.read<AppBloc>().state;
        // appBloc.state;

        final isLoggingIn = state.uri.path == AppRoutes.login;
        // '/login';

        if (appState is AppUnauthenticated) {
          return isLoggingIn ? null : AppRoutes.login;
        }

        if (appState is AppUnauthorized) {
          return AppRoutes.login;
        }

        if (appState is AppAuthenticated) {
          return isLoggingIn ? AppRoutes.dashboard : null;
        }
        return null;
      },
    );
  }
}
