import 'package:flutter/material.dart';

import '../../models/wine_item.dart';
import '../../icons/my_custom_icons.dart';
import 'item_detail.dart';
import 'transition_bottom_sheet.dart';

//виджет для вывода подробной информации о вине
class DetailedExpanded extends StatelessWidget {
  final WineItem wineNote;

  const DetailedExpanded(this.wineNote, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //выводим поочередно факты о вине
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // производитель и год
            InkWell(
              //по тапу вызываем bottomSheet с предложением перейти
              //на экран со всеми заметками этого производителя
              //проверяем - не пустое ли поле
              onTap: wineNote.manufacturer.isEmpty
                  ? () {}
                  : () => showModalBottomSheet(
                        context: context,
                        builder: (context) => TransitionBottomSheet(
                          dataOne: wineNote.manufacturer,
                          typeOne: WineNoteFields.manufacturer,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
              child: ItemDetailInfo(
                title: 'Производитель и год урожая',
                info: _createInfo(
                    wineNote.manufacturer, '${wineNote.year?.year} г.'),
                icon: MyCustomIcons.manufacturer,
                isTap: false,
              ),
            ),

            // Страна и регион
            InkWell(
              onTap: () {
                //по тапу вызываем метод, который оценивает
                //- заполнены ли поля и уже вызывает bottomsheet
                _transition(
                  wineNote.country,
                  wineNote.region,
                  WineNoteFields.country,
                  WineNoteFields.region,
                  context,
                );
              },
              child: ItemDetailInfo(
                title: 'Страна и регион',
                info: _createInfo(wineNote.country, wineNote.region),
                icon: MyCustomIcons.flag,
                isTap: false,
              ),
            ),

            // сорт и цвет
            InkWell(
              //по тапу вызываем метод, который оценивает
              //- заполнены ли поля и уже вызывает bottomsheet
              onTap: () {
                _transition(
                  wineNote.grapeVariety,
                  wineNote.wineColors,
                  WineNoteFields.grapeVariety,
                  WineNoteFields.wineColors,
                  context,
                );
              },
              child: ItemDetailInfo(
                title: 'Сорт и цвет',
                info: _createInfo(wineNote.grapeVariety, wineNote.wineColors),
                icon: MyCustomIcons.grape,
                isTap: false,
              ),
            ),

            const SizedBox(height: 8),
            const Divider(height: 2),
            const SizedBox(height: 8),

            //  аромат
            ItemDetailInfo(
              title: 'Аромат',
              info: wineNote.aroma,
              icon: MyCustomIcons.aroma,
              isTap: true,
            ),

            // вкус
            ItemDetailInfo(
              title: 'Вкус',
              info: wineNote.taste,
              icon: MyCustomIcons.taste,
              isTap: true,
            ),

            // комментарий
            ItemDetailInfo(
              title: 'Комментарий',
              info: wineNote.comment,
              icon: Icons.comment_outlined,
              isTap: true,
            ),

            const SizedBox(height: 8),
            const Divider(height: 2),
            const SizedBox(height: 8),

            //дата создания
            ItemDetailInfo(
              info: _parseDateInString(wineNote.creationDate!),
              icon: Icons.calendar_month_sharp,
              title: 'Дата создания',
              isTap: false,
            ),
          ],
        ),
      ),
    );
  }

  //метод для объединения двух строк
  //учитываем варианты, что одна из строк пустая
  String _createInfo(String dataOne, String dataTwo) {
    String result = '';
    if (dataOne.isEmpty && dataTwo.isEmpty) {
      result = '';
    } else if (dataOne.isNotEmpty && dataTwo.isEmpty) {
      result = dataOne;
    } else if (dataOne.isEmpty && dataTwo.isNotEmpty) {
      result = dataTwo;
    } else {
      result = dataOne + ', $dataTwo';
    }
    return result;
  }

  //метод для создания строки из даты
  String _parseDateInString(DateTime date) {
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    return '${date.day}.$month.${date.year} г.';
  }

  //метод для вызова нижней панели для перехода на страницы со списками вин
  //выясняет, какое поле пустое, какое нет,
  //и сколько вариантов перехода на страницы надо создавать
  void _transition(
    //данные
    String dataFirst,
    String dataSecond,

    //типы данных
    String typeFirst,
    String typeSecond,
    BuildContext context,
  ) {
    //если первые данные отсутсвуют, создаем боттом с вариантом перехода на вторые данные
    if (dataFirst.isEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (context) => TransitionBottomSheet(
          dataOne: dataSecond,
          typeOne: typeSecond,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    //если указаны только первые данные
    //предлагаем перейти на экран со всеми винами по этим данным
    else if (dataSecond.isEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (context) => TransitionBottomSheet(
          dataOne: dataFirst,
          typeOne: typeFirst,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    //если указано все, то предлагаем оба варианта
    else {
      showModalBottomSheet(
        context: context,
        builder: (context) => TransitionBottomSheet(
          dataOne: dataFirst,
          typeOne: typeFirst,
          dataTwo: dataSecond,
          typeTwo: typeSecond,
        ),
        backgroundColor: Colors.transparent,
      );
    }
  }
}
