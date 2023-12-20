import 'package:chater/app/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagingProvider = Provider<MessagingRepository>((ref) {
  return MessagingRepository();
});

