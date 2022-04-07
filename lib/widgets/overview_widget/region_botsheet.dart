import 'package:flutter/material.dart';

//виджет для создания нижней панели для фильтрации вин по регионам
class RegionBottomSheet extends StatelessWidget {
  //принимает список регионов и функцию для сохранения ввода
  final List<String> regions;
  final Function saveRegion;
  const RegionBottomSheet({
    Key? key,
    required this.regions,
    required this.saveRegion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colorScheme.surfaceVariant),
    );
  }
}
