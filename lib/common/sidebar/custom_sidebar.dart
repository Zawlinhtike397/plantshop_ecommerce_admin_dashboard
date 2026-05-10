import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/images/custom_circular_image.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/sidebar/menu_item.dart';
import 'package:plantfiy_plantshop_admin_dashboard/routes/app_routes.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/enums.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';

class ZSideBar extends StatefulWidget {
  const ZSideBar({super.key});

  @override
  State<ZSideBar> createState() => _ZSideBarState();
}

class _ZSideBarState extends State<ZSideBar> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.sidebarBackground,
          border: Border(right: BorderSide(color: Colors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // spacing: 3,
              children: [
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
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 0.5),
                          ZMenuItem(
                            itemName: 'Dashboard',
                            route: AppRoutes.dashboardPath,
                            iconPath: ImageStrings.dashboardIcon,
                          ),
                          ZMenuItem(
                            itemName: 'Products',
                            route: AppRoutes.productsPath,
                            iconPath: ImageStrings.productIcon,
                          ),
                          ZMenuItem(
                            itemName: 'Orders',
                            route: AppRoutes.ordersPath,
                            iconPath: ImageStrings.orderIcon,
                          ),
                          ZMenuItem(
                            itemName: 'Customers',
                            route: AppRoutes.customersPath,
                            iconPath: ImageStrings.customerIcon,
                          ),
                          ZMenuItem(
                            itemName: 'Discount Cupons',
                            route: AppRoutes.discountCuponsPath,
                            iconPath: ImageStrings.discountCuponIcon,
                          ),
                          ZMenuItem(
                            itemName: 'Categories',
                            route: AppRoutes.categoriesPath,
                            iconPath: ImageStrings.categoryIcon,
                          ),
                          SizedBox(height: 9.0),
                          Text(
                            'System',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 0.5),
                          ZMenuItem(
                            itemName: 'Settings',
                            route: AppRoutes.settingsPath,
                            iconPath: ImageStrings.settingsIcon,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageStrings.darkModeIcon,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Dark Mode',
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: AppColor.lightGray,
                                        fontSize: 13,
                                      ),
                                ),
                                Transform.scale(
                                  // scale: 0.7,
                                  scaleX: 0.8,
                                  scaleY: 0.7,
                                  child: SizedBox(
                                    width: 55,
                                    height: 5,
                                    child: Switch(
                                      value: isDarkMode,
                                      activeTrackColor: AppColor.primary,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey.shade400,
                                      onChanged: (value) {
                                        setState(() {
                                          isDarkMode = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ZMenuItem(
                          //   itemName: 'Dark Mode',
                          //   route: null,
                          //   iconPath: ImageStrings.darkModeIcon,
                          // ),
                        ],
                      ),
                      SizedBox(height: 70),
                      Column(
                        spacing: 6.0,
                        children: [
                          Row(
                            spacing: 5.0,
                            children: [
                              Image.network(
                                'assets/logos/avatar_bg.png',
                                width: 60,
                                height: 60,
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.go(AppRoutes.profilePath);
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
                                ],
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
    );
  }
}
