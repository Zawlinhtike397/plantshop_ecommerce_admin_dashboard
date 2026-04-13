import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(ImageStrings.appLogo),
            width: 200,
            height: 200,
          ),
          SizedBox(height: 32.0),
          Text(
            AppTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8.0),
          Text(
            AppTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
