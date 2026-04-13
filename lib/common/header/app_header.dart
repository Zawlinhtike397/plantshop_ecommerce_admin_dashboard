import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/device/device_utility.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AppHeader({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColor.midGray, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AppBar(
        leading: null,

        title: DeviceUtility.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search anything ...',
                  ),
                ),
              )
            : null,
        actions: [
          if (!DeviceUtility.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          SizedBox(width: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx(
              //   () => TRoundedImage(
              //     width: 40,
              //     height: 40,
              //     padding: 2,
              //     imageType: controller.user.value.profilePicture!.isNotEmpty
              //         ? ImageType.network
              //         : ImageType.asset,
              //     image: controller.user.value.profilePicture!.isNotEmpty
              //         ? controller.user.value.profilePicture
              //         : TImages.user,
              //   ),
              // ),
              // SizedBox(width: TSizes.sm),
              // if (!TDeviceUtils.isMobileScreen(context))
              //   Obx(
              //     () => Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         controller.isLoading.value
              //             ? ZShimmerEffect(width: 50, height: 13)
              //             : Text(
              //                 controller.user.value.fullName,
              //                 style: Theme.of(context).textTheme.titleLarge,
              //               ),
              //         controller.isLoading.value
              //             ? ZShimmerEffect(width: 50, height: 13)
              //             : Text(
              //                 controller.user.value.email,
              //                 style: Theme.of(context).textTheme.labelMedium,
              //               ),
              //       ],
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100 + 15);
}
