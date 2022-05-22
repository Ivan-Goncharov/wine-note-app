// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../system_widget/button_container.dart';

//виджет для вывода экрана выбора года урожая
class WineYear extends StatefulWidget {
  //принимаем дату урожая, если она уже указана
  //и функцию, которая меняет дату в замтеке
  DateTime? currentWineYear;
  final Function changeDateNote;
  WineYear({
    Key? key,
    required this.currentWineYear,
    required this.changeDateNote,
  }) : super(key: key);

  @override
  State<WineYear> createState() => _WineYearState();
}

class _WineYearState extends State<WineYear> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Выберите год"),
              content: SizedBox(
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 50, 1),
                  lastDate: DateTime(DateTime.now().year, 1),
                  initialDate: DateTime.now(),
                  selectedDate: widget.currentWineYear ?? DateTime.now(),
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      widget.currentWineYear = dateTime;
                      widget.changeDateNote(dateTime);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      }),
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Год урожая'),
            Text(
              widget.currentWineYear?.year.toString() ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
