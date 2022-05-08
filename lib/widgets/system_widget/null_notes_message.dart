import 'package:flutter/material.dart';

//если нет заметок, то на двух обзорныъ экранах появлятся это сообщение
class NullNotesMessage extends StatelessWidget {
  const NullNotesMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //иконка
            Icon(
              Icons.info_outline,
              size: 60,
              color: colors.secondary,
            ),
            const SizedBox(
              height: 10,
            ),

            //сообщение
            Text(
              'Вы не добавили ни одной заметки',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
