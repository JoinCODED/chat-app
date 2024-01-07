import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:chater/app/modules/one_to_one_chat/domain/providers/message_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingEffect extends ConsumerWidget {
  const LoadingEffect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageProvider = ref.watch(chatMessageStateNotifierProvider);
    return Visibility(
      visible: messageProvider.isLoading,
      child: SizedBox(
        width: context.screenWidth * 0.05,
        height: context.screenWidth * 0.05,
        child: const Center(
          child: CircularProgressIndicator(
            color: MyColors.secondary_400,
          ),
        ),
      ),
    );
  }
}
