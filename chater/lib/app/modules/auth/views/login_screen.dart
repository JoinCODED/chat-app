import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/widgets/auth_appbar.dart';
import 'package:chater/app/modules/auth/widgets/my_auth_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppbar(
        appBarTitle: Text(
          context.translate.login,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyAuthForm(),
          const SizedBox(
            height: 12,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account, "),
              Text("Register Now 😃")
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(context.translate.login),
          ),
        ],
      ),
    );
  }
}
