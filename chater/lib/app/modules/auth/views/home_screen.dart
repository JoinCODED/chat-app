import 'package:chater/app/config/router/named_routes.dart';
import 'package:chater/app/modules/auth/domain/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Page"),
            const SizedBox(
              height: 12,
            ),
            Consumer(builder: (context, ref, child) {
              final authProvider = ref.read(authControllerProvider.notifier);
              final authState = ref.watch(authControllerProvider);
              return ElevatedButton(
                onPressed: () {
                  authProvider.signOut().whenComplete(() {
                    if (authState.isAuth == false) {
                      context.goNamed(MyNamedRoutes.login);
                    }
                  });
                },
                child: const Text("Logout"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
