import 'package:chater/app/core/constants/my_colors.dart';
import 'package:chater/app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin PickAnImageBottomSheet {
  Future showOptions(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
            height: context.screenHeight * 0.3,
            width: context.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text(
                    context.translate.photoGallery,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: MyColors.secondary_500),
                  ),
                  onTap: () {
                    context.pop();
                    //getImageFromGallery();
                  },
                ),
                GestureDetector(
                  child: Text(
                    context.translate.cameraImage,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: MyColors.secondary_500),
                  ),
                  onTap: () {
                    context.pop();
                    //getImageFromCamera();
                  },
                ),
                GestureDetector(
                  child: Text(
                    context.translate.cameraVideo,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: MyColors.secondary_500),
                  ),
                  onTap: () {
                    context.pop();
                    //getVideoFromCamera();
                  },
                ),
                GestureDetector(
                  child: Text(
                    context.translate.cancel,
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: MyColors.primary_500),
                  ),
                  onTap: () {
                    context.pop();
                    //cancel();
                  },
                ),
              ],
            )));
  }
}
