import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';

class AnimationLoader extends StatelessWidget {
  final String text;
  final String animation;
  final void Function()? onPressed;
  final bool showActionButton;
  final String? actionText;
  double? width;
  double? height;

  AnimationLoader({
    super.key,
    required this.text,
    required this.animation,
    this.onPressed,
    this.showActionButton = false,
    this.actionText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 24.0,
        children: [
          LottieBuilder.asset(
            animation,
            width: width ?? MediaQuery.of(context).size.width * 0.8,
            height: height ?? MediaQuery.of(context).size.height * 0.4,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          showActionButton
              ? SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColor.darkerGrey,
                    ),
                    onPressed: onPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColor.primaryBackground,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
