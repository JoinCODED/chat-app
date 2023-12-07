import 'package:chater/app/config/router/named_routes.dart';
import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/domain/providers/auth_providers.dart';
import 'package:chater/app/modules/auth/domain/providers/controller/form_controller.dart';
import 'package:chater/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:chater/app/modules/auth/widgets/auth_appbar.dart';
import 'package:chater/app/modules/auth/widgets/my_auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppbar(
        appBarTitle: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthForm(fromRegister: true, registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${context.translate.alreadyHaveAnAccount}, "),
              GestureDetector(
                onTap: () {
                  context.goNamed(MyNamedRoutes.login);
                },
                child: Text(
                  context.translate.pleaseLogin,
                  style: context.theme.textTheme.bodyLarge
                      ?.copyWith(color: MyColors.blue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer(builder: (_, ref, __) {
            final authStateProvider =
                ref.watch(authControllerProvider.notifier);
            final AuthState authState = ref.watch(authControllerProvider);
            final MyAuthFormController authFormContrller =
                ref.watch(authFormController);
            return ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  authStateProvider
                      .register(
                    email: authFormContrller.email,
                    userName: authFormContrller.userName,
                    password: authFormContrller.password,
                  )
                      .then((result) {
                    if (result == true) {
                      context.goNamed(MyNamedRoutes.login);
                    } else if (authState.error != null) {
                      context.showSnackbar(authState.error.toString());
                    }
                  });
                }
              },
              child: authState.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        color: MyColors.white,
                      ),
                    )
                  : Text(
                      context.translate.register,
                    ),
            );
          }),
        ],
      ),
    );
  }
}
