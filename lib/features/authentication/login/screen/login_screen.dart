import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/common/templates/layout_template.dart';
import 'package:plantfiy_plantshop_admin_dashboard/data/repositories/authentication_repository.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/bloc/login_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/responsive/login_screen_desktop_tablet.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/authentication/login/screen/responsive/login_screen_mobile.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/popups/fullscreen_loader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginInitial():
              FullscreenLoader.hide(context);
              break;
            case LoginLoading():
              FullscreenLoader.showLoader(
                context,
                text: 'Performing sign-in...',
              );
              break;
            case LoginSuccess():
              FullscreenLoader.hide(context);
              break;
            case LoginFailure(error: final message):
              FullscreenLoader.hide(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              break;
          }
        },
        child: LayoutTemplate(
          useLayout: false,
          desktop: LoginScreenDesktopTablet(),
          mobile: LoginScreenMobile(),
        ),
      ),
    );
  }
}
