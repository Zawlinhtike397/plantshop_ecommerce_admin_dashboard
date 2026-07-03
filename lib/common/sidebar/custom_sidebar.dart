import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/dropdown/custom_dropdown.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/images/custom_circular_image.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/menu_item.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/enums.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/themes/cubit/theme_cubit.dart';
import 'package:url_launcher/link.dart';

class ZSideBar extends StatefulWidget {
  const ZSideBar({super.key});

  @override
  State<ZSideBar> createState() => _ZSideBarState();
}

class _ZSideBarState extends State<ZSideBar> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isAutoDarkEnabled =
        themeState.autoDarkModeOption == 'System Setting';

    return SafeArea(
      top: false,
      child: Drawer(
        shape: BeveledRectangleBorder(),
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColor.dark1 : AppColor.sidebarBackground,
            border: Border(
              right: BorderSide(
                color: isDarkMode ? Colors.black87 : Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                // spacing: 3,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCircularImage(
                        image: ImageStrings.appLogo,
                        imageType: ImageType.asset,
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 8.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Sales',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: isDarkMode
                                        ? Colors.grey.shade400
                                        : AppColor.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 0.5),
                            ZMenuItem(
                              itemName: 'Dashboard',
                              route: AppRoutes.dashboard,
                              iconPath: ImageStrings.dashboardIcon,
                            ),
                            ZMenuItem(
                              itemName: 'Products',
                              route: AppRoutes.products,
                              iconPath: ImageStrings.productIcon,
                            ),
                            ZMenuItem(
                              itemName: 'Orders',
                              route: AppRoutes.orders,
                              iconPath: ImageStrings.orderIcon,
                            ),
                            ZMenuItem(
                              itemName: 'Customers',
                              route: AppRoutes.customers,
                              iconPath: ImageStrings.customerIcon,
                            ),
                            ZMenuItem(
                              itemName: 'Discount Cupons',
                              route: AppRoutes.discountCupons,
                              iconPath: ImageStrings.discountCuponIcon,
                            ),
                            ZMenuItem(
                              itemName: 'Categories',
                              route: AppRoutes.categories,
                              iconPath: ImageStrings.categoryIcon,
                            ),
                            SizedBox(height: 9.0),
                            Text(
                              'System',
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: isDarkMode
                                        ? Colors.grey.shade400
                                        : AppColor.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 0.5),
                            ZMenuItem(
                              itemName: 'Settings',
                              route: AppRoutes.settings,
                              iconPath: ImageStrings.settingsIcon,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageStrings.darkModeIcon,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Dark Mode',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColor.lightGray,
                                              fontSize: 13,
                                            ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<ThemeCubit, ThemeState>(
                                    builder: (context, state) {
                                      return Transform.scale(
                                        scaleX: 0.8,
                                        scaleY: 0.9,
                                        child: SizedBox(
                                          width: 55,
                                          child: Switch(
                                            value: isDarkMode,
                                            activeTrackColor: AppColor.primary,
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            onChanged: isAutoDarkEnabled
                                                ? null
                                                : (value) {
                                                    if (value) {
                                                      context
                                                          .read<ThemeCubit>()
                                                          .setDarkMode();
                                                    } else {
                                                      context
                                                          .read<ThemeCubit>()
                                                          .setLightMode();
                                                    }
                                                  },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0.5),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Text(
                                        'Auto Dark Mode',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: AppColor.lightGray,
                                              fontSize: 13,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColor.dark2
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: CustomDropdown(
                                      isDarkMode: isDarkMode,
                                      value: themeState.autoDarkModeOption,
                                      itemsValue: ['Off', 'System Setting'],
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          context
                                              .read<ThemeCubit>()
                                              .updateAutoDarkModeOption(
                                                newValue,
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 70),
                        Column(
                          spacing: 6.0,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                AppCircularImage(
                                  image: ImageStrings.avatarPlaceHolder,
                                  imageType: ImageType.asset,
                                  width: 60,
                                  height: 60,
                                  padding: 0,
                                  backgroundColor: Colors.transparent,
                                ),

                                Link(
                                  uri: Uri.parse(AppRoutes.profile),
                                  builder: (context, followLink) => InkWell(
                                    onTap: () {
                                      followLink?.call();
                                      context.go(AppRoutes.profile);
                                    },
                                    child: Text(
                                      'Plantify Admin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColor.darkTeal,
                                            fontSize: 13,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: ZMenuItem(
                                    itemName: 'Logout',
                                    route: AppRoutes.logout,
                                    iconPath: ImageStrings.logoutIcon,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
