import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/cubit/sidebar_cubit.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/app/bloc/app_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class ZMenuItem extends StatelessWidget {
  final String iconPath;
  final String itemName;
  final String? route;

  const ZMenuItem({
    super.key,
    required this.iconPath,
    required this.itemName,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SidebarCubit>();
    final state = context.watch<SidebarCubit>().state;

    final isActive = state.activeItem == route;
    final isHovering = state.hoverItem == route;

    return InkWell(
      onTap: () {
        if (route == AppRoutes.logout) {
          context.read<AppBloc>().add(LoggedOut());
          return;
        }

        if (route != null) {
          cubit.setActive(route!);
          context.go(route!);
        }
      },
      onHover: (hovering) {
        if (route == AppRoutes.logout) {
          return;
        }
        if (route != null) {
          hovering ? cubit.setHover(route!) : cubit.clearHover();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: (isActive || isHovering)
              ? AppColor.menuItemBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                (isActive || isHovering)
                    ? AppColor.primary
                    : AppColor.lightGray,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                itemName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: (isActive || isHovering)
                      ? AppColor.primary
                      : AppColor.lightGray,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
