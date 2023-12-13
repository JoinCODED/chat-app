import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:chater/app/modules/chats/domain/providers/providers.dart';
import 'package:chater/app/modules/shared/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsRepo = ref.watch(chatsRepositoryProvider);
    return Scaffold(
      appBar: const MyAppbar(appBarTitle: Text("Registered Users")),
      body: FutureBuilder<List<User>>(
        future: chatsRepo.fetchRegisteredUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.email),
                    // Other user details or actions
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


/*
Consumer(builder: (context, ref, child) {
              final authProvider = ref.read(authControllerProvider.notifier);
              final authState = ref.watch(authControllerProvider);
              return ElevatedButton(
                onPressed: () {
                  authProvider.signOut().then((result) {
                    if (result == true) {
                      context.goNamed(MyNamedRoutes.register);
                    }
                  });
                },
                child: authState.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircularProgressIndicator(
                          color: MyColors.primary_500,
                        ),
                      )
                    : const Text("Logout"),
              );
            }),
*/
