import 'package:flutter/material.dart';

class SectionHeadingText extends StatelessWidget {
  const SectionHeadingText({
    super.key,
    this.textColor,
    required this.title,
    this.rightSideWidget,
  });

  final Color? textColor;
  final Widget? rightSideWidget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (rightSideWidget != null) rightSideWidget!,
      ],
    );
  }
}
