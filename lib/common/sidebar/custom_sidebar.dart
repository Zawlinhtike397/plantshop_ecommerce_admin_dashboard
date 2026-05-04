// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:plantfiy_plantshop_admin_dashboard/common/images/custom_circular_image.dart';
// import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
// import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/enums.dart';
// import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';

// class ZSideBar extends StatelessWidget {
//   const ZSideBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       shape: BeveledRectangleBorder(),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColor.white,
//           border: Border(right: BorderSide(color: Colors.grey, width: 1)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               AppCircularImage(
//                 image: ImageStrings.appLogo,
//                 imageType: ImageType.asset,
//                 width: 100,
//                 height: 100,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   spacing: 4.0,
//                   children: [
//                     ZMenuItem(
//                       itemName: 'Dashboard',
//                       route: ZRoutes.dashboard,
//                       icon: Iconsax.status,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Media',
//                       route: ZRoutes.media,
//                       icon: Iconsax.image,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Category',
//                       route: ZRoutes.categories,
//                       icon: Iconsax.category_2,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Brands',
//                       route: ZRoutes.brands,
//                       icon: Iconsax.dcube,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Banners',
//                       route: ZRoutes.banners,
//                       icon: Iconsax.picture_frame,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Products',
//                       route: ZRoutes.products,
//                       icon: Iconsax.shopping_bag,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Customers',
//                       route: ZRoutes.customer,
//                       icon: Iconsax.profile_2user,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Orders',
//                       route: ZRoutes.orders,
//                       icon: Iconsax.box,
//                     ),

//                     Text(
//                       'OTHER',
//                       style: Theme.of(
//                         context,
//                       ).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
//                     ),
//                     ZMenuItem(
//                       itemName: 'Profile',
//                       route: ZRoutes.profile,
//                       icon: Iconsax.user,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Settings',
//                       route: ZRoutes.settings,
//                       icon: Iconsax.setting_2,
//                     ),
//                     ZMenuItem(
//                       itemName: 'Logout',
//                       route: 'logout',
//                       icon: Iconsax.logout,
//                     ),

//                     // ZMenuItem(
//                     //   itemName: 'Banners',
//                     //   route: ZRoutes.responsiveDesignTuto1,
//                     //   icon: Iconsax.picture_frame,
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
