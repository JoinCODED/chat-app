import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/auth/widgets/auth_appbar.dart';
import 'package:chater/app/modules/auth/widgets/my_auth_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppbar(
        appBarTitle: Text(
          context.translate.register,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const MyAuthForm(),
          const Text(""),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text(
              "Register",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
