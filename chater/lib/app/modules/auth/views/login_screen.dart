import 'package:chater/app/config/router/named_routes.dart';
import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/widgets/auth_appbar.dart';
import 'package:chater/app/modules/auth/widgets/my_auth_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${context.translate.dontHaveAnAccount}, "),
              GestureDetector(
                onTap: () {
                  context.goNamed(MyNamedRoutes.register);
                },
                child: Text(
                  "${context.translate.registerNow} 😃",
                  style: context.theme.textTheme.bodyLarge
                      ?.copyWith(color: MyColors.blue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
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
