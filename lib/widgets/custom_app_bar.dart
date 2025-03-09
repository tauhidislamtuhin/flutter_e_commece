import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final String? title;
  const CustomAppBar({super.key, this.leading, this.actions, this.backgroundColor, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor??Colors.white,
      leading: leading ?? IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: Text(title!),
      centerTitle: false,
      actions: actions,

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
