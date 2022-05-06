// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//кастомный appbar для всех экранов
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? listOfAction;
  CustomAppBar({Key? key, required this.title, this.listOfAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      actions: listOfAction,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
