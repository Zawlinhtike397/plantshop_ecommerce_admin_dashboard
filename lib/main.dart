import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/cubit/sidebar_cubit.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/authentication_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/order_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/product_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/stock_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/screen/app.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/order/bloc/order_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/product/bloc/product_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/stock/bloc/stock_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
              authRepository: context.read<AuthenticationRepository>(),
            )..add(AppStarted()),
          ),
          BlocProvider(create: (_) => SidebarCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(
            create: (context) =>
                OrderBloc(repository: context.read<OrderRepository>())
                  ..add(FetchOrders()),
          ),
          BlocProvider(
            create: (_) =>
                StockBloc(repository: StockRepository())
                  ..add(FetchLowStockItems()),
          ),
          BlocProvider(
            create: (context) =>
                ProductBloc(repository: context.read<ProductRepository>())
                  ..add(FetchAllProducts()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
