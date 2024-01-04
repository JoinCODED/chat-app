
import 'package:flutter/material.dart';

mixin CustomDateTimeFormatter {
   String formatChatDateTime(DateTime dateTime, BuildContext context) {
    // Format the DateTime to a more concise representation for chat messages
    final timeFormat = TimeOfDay.fromDateTime(dateTime).format(context);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return 'Today, $timeFormat';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday, $timeFormat';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}, $timeFormat';
    }
  }
}
