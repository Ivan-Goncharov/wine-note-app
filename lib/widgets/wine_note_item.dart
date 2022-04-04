import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';
import 'package:provider/provider.dart';

import '../models/wine_item.dart';

//виджет для отображения одного элемента в списке вин
class WineNoteItem extends StatelessWidget {
  //принимаем через конструктор нашу заметку о вине
  final WineItem wineNote;

  const WineNoteItem(this.wineNote, {Key? key}) : super(key: key);

// фоновый цвет вкладки, взависимости от вина
  Color getColor(String? wineColor) {
    switch (wineColor) {
      case 'Красное':
        return Colors.red.shade400;
      case 'Оранжевое':
        return Colors.orange.shade400;
      case 'Розовое':
        return Colors.red.shade200;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (wineNote.imageUrl.isEmpty) {
      wineNote.imageUrl = wineNote.changeImage();
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      //меняем цвет карты, в зависимости от вина
      color: getColor(wineNote.wineColors),
      child: ListTile(
        //по нажатию на карточку, открырвается полное описание
        onTap: () {
          Navigator.of(context).pushNamed(WineFullDescripScreen.routName,
              arguments: wineNote.id);
        },

        leading: SizedBox(
          width: 50,
          height: 100,
          child: FittedBox(
            fit: BoxFit.contain,
            child: wineNote.imageUrl.contains('asset')
                ? Image.asset(
                    wineNote.imageUrl,
                  )
                : Image.file(File(wineNote.imageUrl)),
          ),
        ),
        title: Text(
          '${wineNote.name}, ${wineNote.year!.year}г.',
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          '${wineNote.manufacturer}, ${wineNote.region}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
