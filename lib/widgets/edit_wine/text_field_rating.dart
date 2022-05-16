import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../models/wine_rating.dart';
import '../../widgets/edit_wine/bottom_sheet_rating.dart';
import '../../widgets/edit_wine/button_container.dart';

//виджет для изменения рейтинга вина
class TextFieldRating extends StatefulWidget {
  //принимает текущий рейтинг
  final WineRating rating;
  //функцию для сохранения рейтинга в заметке
  final Function saveRating;
  const TextFieldRating(
      {Key? key, required this.rating, required this.saveRating})
      : super(key: key);

  @override
  State<TextFieldRating> createState() => _TextFieldRatingState();
}

class _TextFieldRatingState extends State<TextFieldRating> {
  //переменная для хранения и изменения рейтинга вина
  double _averageRating = 0.0;

  @override
  void initState() {
    //инициализируем данными, которые пользователь уже вводил
    _averageRating = widget.rating.averageRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //по тапу переходим на экран с указанием рейтинга
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => BottomSheetRating(rating: widget.rating),
        ).then((newRating) {
          //если сохранен пользователем, то изменяем данные переменной среднего рейтинга
          if (newRating != null) {
            setState(
              () => _averageRating = (newRating as WineRating).averageRating(),
            );
            //и сохраняем данные в заметке
            widget.saveRating(newRating);
          }
        });
      },

      //выводим данные по рейтингу
      child: ButtonContainer(
        child: Row(
          children: [
            //заголовок
            const Text('Рейтинг'),
            const SizedBox(width: 2),

            //если рейтинг = 0, ничего не выводим на экран
            _averageRating == 0.0
                ? const SizedBox()

                //выводим рейтинг
                : Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //иконка
                        Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        const SizedBox(width: 5),

                        //значение
                        Text(
                          _averageRating.toStringAsFixed(2),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
