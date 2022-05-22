import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/wine_item.dart';
import '../system_widget/toast_message.dart';
import 'colors_botsheet.dart';
import 'region_botsheet.dart';

//кнопка для фильтрации по регионам или цветам винограда
class FilterButton extends StatelessWidget {
  //название фильтра
  final String filterName;
  //список регионов
  final List<String> regions;
  //выбранные данные
  final String selectData;
  //функция для сохранения выбора
  final Function changeData;
  const FilterButton(
      {Key? key,
      required this.filterName,
      required this.regions,
      required this.selectData,
      required this.changeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.tune,
        size: 32,
      ),
      onPressed: () {
        //если фильтр по регионам стран
        if (filterName == WineNoteFields.country) {
          //если список регионов пуст - вызываем сообщение об этом
          if (regions.isEmpty) {
            final FToast fToast = FToast();
            fToast.init(context);
            fToast.showToast(
              child: const ToastMessage(
                  message: 'Фильтр по регионам недоступен',
                  iconData: Icons.error_outline),
            );
          }

          //иначе вызываем bottomsheet с вариантами фильтрации
          else {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return RegionBottomSheet(
                  regions: regions,
                  selectRegion: selectData,
                  saveRegion: changeData,
                );
              },
            );
          }
        }

        //фильтр по цветам винограда
        else {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ColorsBotoomsheet(
                saveColor: changeData,
                selectColor: selectData,
              );
            },
          );
        }
      },
    );
  }
}
