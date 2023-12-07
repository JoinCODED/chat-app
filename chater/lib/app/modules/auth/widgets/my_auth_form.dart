// ignore_for_file: unused_element

import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/domain/helpers/auth_validators.dart';
import 'package:chater/app/modules/auth/domain/providers/auth_providers.dart';
import 'package:chater/app/modules/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAuthForm extends ConsumerStatefulWidget {
  const MyAuthForm({super.key, required this.fromRegister});
  final bool fromRegister;

  @override
  ConsumerState createState() => _MyAuthFormState();
}

class _MyAuthFormState extends ConsumerState<MyAuthForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authValidators = AuthValidators();
    final authStateProvider = ref.watch(authControllerProvider.notifier);
    final TextEditingController emailController = TextEditingController();
    final FocusNode emailFocusNode = FocusNode();

    final TextEditingController userNameController = TextEditingController();
    final FocusNode userNameFocus = FocusNode();

    final TextEditingController passwordController = TextEditingController();
    final FocusNode passwordFocusNode = FocusNode();

    @override
    void dispose() {
      super.dispose();
      emailController.dispose();
      emailFocusNode.dispose();

      passwordController.dispose();
      passwordFocusNode.dispose();

      userNameController.dispose();
      userNameFocus.dispose();
    }

    return SizedBox(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextFormWidget(
                controller: emailController,
                obscureText: false,
                focusNode: emailFocusNode,
                validator: (input) {
                  return authValidators.emailValidator(input);
                },
                prefIcon: const Icon(Icons.email),
                labelText: context.translate.email,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  return authStateProvider.setEmailField(value);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Visibility(
                visible: widget.fromRegister,
                child: Column(
                  children: [
                    MyTextFormWidget(
                      controller: userNameController,
                      obscureText: false,
                      focusNode: userNameFocus,
                      validator: (input) =>
                          authValidators.userNameValidator(input),
                      prefIcon: const Icon(Icons.person),
                      labelText: context.translate.userName,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        return authStateProvider.setUserNameField(value);
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              MyTextFormWidget(
                controller: passwordController,
                obscureText: false,
                focusNode: passwordFocusNode,
                validator: (input) => authValidators.passwordVlidator(input),
                prefIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  return authStateProvider.setPasswordField(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
