import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';

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
        return Colors.red;
      case 'Оранжевое':
        return Colors.orange;
      case 'Розовое':
        return const Color.fromRGBO(255, 192, 203, 1);
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    //тэг для анимированного перехода на экран с описанием заметки
    final heroTag = '${wineNote.id} ${DateTime.now().toIso8601String()}';
    if (wineNote.imageUrl.isEmpty) {
      wineNote.imageUrl = wineNote.changeImage();
    }
    return GestureDetector(
      //переходим на экран с подробным описанием заметки
      //передаем id заметки и тэг для hero анимации
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: ((context, animation, secondaryAnimation) {
            return WineFullDescripScreen(
              heroTag: heroTag,
              wineNoteId: wineNote.id!,
            );
          }),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.secondaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: size.height * 0.1,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            //изображение заметки
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: heroTag,
                  child: wineNote.imageUrl.contains('asset')
                      ? Image.asset(
                          wineNote.imageUrl,
                        )
                      : Image.file(
                          File(wineNote.imageUrl),
                        ),
                ),
              ),
            ),

            //текстовые данные
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //название и год
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${wineNote.name}, ',
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '${wineNote.year!.year} г. ',
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),

                  //производитель и регион
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${wineNote.manufacturer}, ',
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Text(
                        wineNote.region,
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //цвет вина в виде круга с соотвествующим цветом
            Container(
              width: size.width * 0.09,
              decoration: BoxDecoration(
                color: getColor(wineNote.wineColors),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.onSecondaryContainer,
                  width: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
