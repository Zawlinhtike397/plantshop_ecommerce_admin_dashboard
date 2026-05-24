import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/containers/app_rounded_container.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class OverallDataCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final int stats;
  final IconData? icon;
  final Color? color;
  final void Function()? onTap;

  const OverallDataCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.stats,
    this.icon = Icons.arrow_drop_up,
    this.color = AppColor.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColor.midGray),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 16.0),
                  Flexible(
                    child: Text(
                      '$stats%',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: color,
                        // TColors.success,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isTiny = constraints.maxWidth < 170;

              return Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: isTiny ? 85 : 115,
                      child: Text(
                        isTiny ? 'From Dec 2025' : 'Compared to Dec 2025',
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
