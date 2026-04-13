import 'package:flutter/material.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.email,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      // controller: widget.emailController,
                      decoration: InputDecoration(
                        hintText: AppTexts.emailHintText,
                      ),
                      // validator: (value) => Validator.validateEmail(value),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.password,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      // controller: widget.passwordController,
                      // obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: AppTexts.passwordHintText,
                        // suffixIcon: widget.passwordController.text.isNotEmpty
                        //     ? IconButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             _obscurePassword = !_obscurePassword;
                        //           });
                        //         },
                        //         icon: Icon(
                        //           _obscurePassword
                        //               ? Icons.visibility_off
                        //               : Icons.visibility,
                        //         ),
                        //       )
                        //     : null,
                      ),
                      // validator: (value) =>
                      //     Validator.validateIsEmpty(value, 'Password'),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.0 / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(AppTexts.forgetPassword),
                ),
              ],
            ),

            SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // await controller.adminLoginWithEmailAndPassword();
                },
                child: Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
