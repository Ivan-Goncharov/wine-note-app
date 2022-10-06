import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/wine_item.dart';
import '../models/wine_rating.dart';
import '../models/wine_database_provider.dart';
import '../widgets/details_widgets/detailed_expanded_notes.dart';
import '../widgets/details_widgets/full_screen_image.dart';
import '../widgets/system_widget/app_bar.dart';

//Экран для полного описания вина
class WineFullDescripScreen extends StatefulWidget {
  static const routName = './wine_full_description';
  //принимаем id заметки
  final String wineNoteId;
  //тэг для hero анимации
  final String heroTag;

  const WineFullDescripScreen({
    Key? key,
    required this.wineNoteId,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<WineFullDescripScreen> createState() => _WineFullDescripScreenState();
}

class _WineFullDescripScreenState extends State<WineFullDescripScreen> {
  @override
  Widget build(BuildContext context) {
    //получаем заметку через id
    final WineItem _wineNote =
        Provider.of<WineDatabaseProvider>(context, listen: true)
            .findById(widget.wineNoteId);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: _wineNote.name,
        listOfAction: [
          //кнопка "Изменить заметку"
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                editWineRoute,
                arguments: _wineNote.id,
              );
            },
            icon: const Icon(
              Icons.create,
              size: 30,
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),

              //рейтинг вина
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //иконка
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 25,
                  ),
                  const SizedBox(width: 5),

                  //значение
                  Text(
                    WineRating.staticAverageMethod(
                      _wineNote.ratingAppearance,
                      _wineNote.ratingAroma,
                      _wineNote.ratingTaste,
                    ).toStringAsFixed(2),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            //выводим изображение вина
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  child: _wineNote.imageUrl.contains('assets')

                      //если изображение системное, то выводим через Assets
                      ? Image(
                          image: AssetImage(
                            _wineNote.imageUrl,
                          ),
                          width: MediaQuery.of(context).size.height * 0.25,
                        )

                      //если пользовательское, оборачиваем в tap
                      //для перехода на экран с полным изображенеим вина
                      : GestureDetector(
                          onTap: () {
                            //переход на экран
                            Navigator.of(context).push(
                              PageTransition(
                                opaque: false,
                                child: FullImageScreen(
                                  imageUrl: _wineNote.imageUrl,
                                ),
                                type: PageTransitionType.size,
                                alignment: Alignment.center,
                                reverseDuration:
                                    const Duration(milliseconds: 500),
                              ),
                            );
                          },

                          //изображение
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: LimitedBox(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  File(_wineNote.imageUrl),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                  tag: widget.heroTag,
                ),
              ),
            ),

            //крепкость и стоимость
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //крепкость
                  _wineNote.alcoPercent != 0.0
                      ? Text(
                          _wineNote.alcoPercent.toStringAsFixed(1) + '% vol.',
                          style: _textStyle())
                      : const SizedBox(),

                  //стоимость
                  _wineNote.price != 0.0
                      ? Text(_wineNote.price.toStringAsFixed(0) + ' р.',
                          style: _textStyle())
                      : const SizedBox(),
                ],
              ),
            ),

            //выводим поочередно факты о вине
            DetailedExpanded(_wineNote),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
    );
  }
}
