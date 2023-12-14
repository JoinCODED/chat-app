import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/chats/domain/models/user_model.dart';
import 'package:chater/app/modules/chats/domain/providers/providers.dart';
import 'package:chater/app/modules/chats/widgets/chat_user_card.dart';
import 'package:chater/app/modules/shared/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: MyAppbar(appBarTitle: Text(context.translate.users)),
      body: chatUsers.when(data: (List<User> data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final user = data[index];
            return ChatUserCard(user: user);
          },
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text(context.translate.errorFetchingUsers));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
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
