// ignore_for_file: unused_element

import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/domain/helpers/auth_validators.dart';
import 'package:chater/app/modules/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';

class MyAuthForm extends StatefulWidget {
  const MyAuthForm({super.key});

  @override
  State createState() => _MyAuthFormState();
}

class _MyAuthFormState extends State<MyAuthForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final emailFocusNode = FocusNode();

    final passwordController = TextEditingController();
    final passwordFocusNode = FocusNode();

    final authValidators = AuthValidators();

    @override
    void dispose() {
      super.dispose();
      emailController.dispose();
      emailFocusNode.dispose();

      passwordController.dispose();
      passwordFocusNode.dispose();
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
                  validator: (input) => authValidators.emailValidator(input),
                  prefIcon: const Icon(Icons.email),
                  labelText: context.translate.email,
                  textInputAction: TextInputAction.next,
                  isNonPasswordField: false),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                  controller: passwordController,
                  obscureText: true,
                  focusNode: passwordFocusNode,
                  validator: (input) => authValidators.passwordVlidator(input),
                  prefIcon: const Icon(Icons.password),
                  labelText: context.translate.password,
                  textInputAction: TextInputAction.done,
                  isNonPasswordField: true),
            ],
          ),
        ),
      ),
    );
  }
}
