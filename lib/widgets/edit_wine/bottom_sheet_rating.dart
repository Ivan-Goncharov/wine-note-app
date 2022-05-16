import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// виджет, который вызывается, когда пользователь нажимает кнопку ввода рейтинга
class BottomSheetRating extends StatelessWidget {
  //принимает текущий рейтинг
  final WineRating rating;

  const BottomSheetRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //иконка для сохранения рейтинга
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, rating);
                },
                icon: const Icon(
                  Icons.check,
                  size: 40,
                ),
              )
            ],
          ),

          //аромат
          Expanded(
            child: ItemRating(
              rating: rating.ratingAroma,
              //изменяем данные в экземлпяре класса рейтинга
              changeRating: (newRating) => rating.ratingAroma = newRating,
              title: 'Аромат вина',
            ),
          ),

          //вкус
          Expanded(
            child: ItemRating(
              rating: rating.ratingTaste,
              changeRating: (newRating) => rating.ratingTaste = newRating,
              title: 'Вкус вина',
            ),
          ),
          //внешний вид
          Expanded(
            child: ItemRating(
              rating: rating.ratingAppearance,
              changeRating: (newRating) => rating.ratingAppearance = newRating,
              title: 'Внешний вид вина',
            ),
          ),
        ],
      ),
    );
  }
}

//виджет для вывода одного типа рейтинга
class ItemRating extends StatelessWidget {
  //значение
  final double rating;
  //заголовок
  final String title;
  //функция для изменения рейтинга
  final Function changeRating;
  const ItemRating(
      {Key? key,
      required this.rating,
      required this.changeRating,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //заголовок
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),

        //рейтингбар
        RatingBar.builder(
          initialRating: rating,
          allowHalfRating: true,
          updateOnDrag: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          onRatingUpdate: (newRating) => changeRating(newRating),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
