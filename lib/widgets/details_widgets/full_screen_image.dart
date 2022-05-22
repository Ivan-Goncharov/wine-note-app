import 'dart:io';

import 'package:flutter/material.dart';

//виджет для вывода изображение во весь экран
class FullImageScreen extends StatelessWidget {
  //ссылка на изображение
  final String imageUrl;
  const FullImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('Key'),
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Image.file(
          File(imageUrl),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
