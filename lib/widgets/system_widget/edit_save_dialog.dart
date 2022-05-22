import 'package:flutter/material.dart';

//диалог для сохранения заметки
class EditWineDialog extends StatelessWidget {
  final Function saveNote;
  const EditWineDialog({Key? key, required this.saveNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выход'),
      content: const Text('Сохранить введенные данные?'),
      actions: [
        //Не сохранять
        TextButton(
          onPressed: (() {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
          child: const Text(
            'Нет',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //сохранять
        TextButton(
          onPressed: () => saveNote(),
          child: const Text(
            'Да',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
