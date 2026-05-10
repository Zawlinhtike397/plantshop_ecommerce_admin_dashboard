import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/cubit/sidebar_cubit.dart';

class SidebarSyncWrapper extends StatefulWidget {
  final Widget child;

  const SidebarSyncWrapper({super.key, required this.child});

  @override
  State<SidebarSyncWrapper> createState() => _SidebarSyncWrapperState();
}

class _SidebarSyncWrapperState extends State<SidebarSyncWrapper> {
  String? _lastLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final location = GoRouterState.of(context).uri.toString();
    if (_lastLocation != location) {
      _lastLocation = location;
      context.read<SidebarCubit>().setActive(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
