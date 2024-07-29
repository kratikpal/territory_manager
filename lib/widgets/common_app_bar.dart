import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final TabBar? bottom;

  const CommonAppBar({super.key, required this.title, this.actions, required Color backgroundColor, required int elevation, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
              color: Colors.white);
        }),
        backgroundColor: Colors.transparent,
        bottom: bottom,
        title: title,
        toolbarHeight: kToolbarHeight+20,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
