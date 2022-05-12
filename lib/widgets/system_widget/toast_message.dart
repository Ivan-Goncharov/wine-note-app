import 'package:flutter/material.dart';

//виджет для вывода уведомления об операции
class ToastMessage extends StatelessWidget {
  //принимает сообщение , которое надо вывести и иконоку
  final String message;
  final IconData iconData;
  const ToastMessage({Key? key, required this.message, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: colors.onSecondary,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Flexible(
              child: Text(
                message,
                softWrap: false,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
