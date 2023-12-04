import 'package:chater/app/core/constants/my_colors.dart';
import 'package:flutter/material.dart';

class AuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppbar(
      {super.key, required this.appBarTitle, this.showLeading = false});

  final Text appBarTitle;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showLeading,
      title: appBarTitle,

      /// convert this color to a passed dynamic parameter like [showLeading] and [appBarTitle]
      backgroundColor: MyColors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
