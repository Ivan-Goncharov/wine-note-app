//кнопка для фильтрации по регионам или цветам винограда
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/wine_item.dart';
import '../system_widget/toast_message.dart';
import 'colors_botsheet.dart';
import 'region_botsheet.dart';

class FilterButton extends StatelessWidget {
  final String filterName;
  final List<String> regions;
  final String selectData;
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
        if (filterName == WineNoteFields.country) {
          if (regions.isEmpty) {
            final FToast fToast = FToast();
            fToast.init(context);
            fToast.showToast(
              child: const ToastMessage(
                  message: 'Фильтр по регионам недоступен',
                  iconData: Icons.error_outline),
            );
          } else {
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
        } else {
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
