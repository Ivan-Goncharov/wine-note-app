import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_item.dart';
import '../../models/wine_sorted_provider.dart';
import '../../widgets/overview_widget/region_botsheet.dart';
import '../../widgets/wine_note_item.dart';

//экран для вывода всех заметок, связанных с одной страной
class ItemCountryNotes extends StatefulWidget {
  static const routName = ' ./itemCountry';
  const ItemCountryNotes({Key? key}) : super(key: key);

  @override
  State<ItemCountryNotes> createState() => _ItemCountryNotesState();
}

class _ItemCountryNotesState extends State<ItemCountryNotes> {
  //провайдер
  late WineSortProvider _provider;
  //название страны
  String _country = '';
  // переменная для отслеживания - инициализированны данные или нет
  bool _isInit = false;
  //цветовая схема
  late ColorScheme _colorScheme;
  //переменная для сохранения выбранного региона
  String _selectRegion = '';

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      //подключаем провайдер
      _provider = Provider.of<WineSortProvider>(context);
      //получаем название страны
      _country = ModalRoute.of(context)!.settings.arguments as String;
      //запускаем метод с поиском всех заметок с этой страной
      _provider.fetchCustomNotes(WineNoteFields.country, _country);
      //получаем цветовую схему
      _colorScheme = Theme.of(context).colorScheme;
      //отмечаем, что инициализация проведена
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_country),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          //кнопка для вывода меню с фильтром по регионам
          GestureDetector(
            child: filterButton(context),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  //передаем список регионов, выбранный регион
                  //и метод для изменения региона
                  return RegionBottomSheet(
                    regions: _provider.regions,
                    selectRegion: _selectRegion,
                    saveRegion: changeRegion,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          //выводим список всех заметок по стране
          itemBuilder: (context, index) {
            return WineNoteItem(_provider.filterList[index]);
          },
          itemCount: _provider.filterList.length,
        ),
      ),
    );
  }

  //кнопка - фильтр для appbar
  Widget filterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colorScheme.surfaceVariant,
      ),
      child: Row(
        children: [
          Text(
            'Регионы',
            style: TextStyle(
              color: _colorScheme.onSurfaceVariant,
              fontSize: 15,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_outlined,
            color: _colorScheme.onSurfaceVariant,
          )
        ],
      ),
    );
  }

  //метод для смены региона
  void changeRegion(String newRegion) {
    setState(() => _selectRegion = newRegion);
    //проверяем, выбран ли регион или нет
    //если фильтр не выбрае, то выводим все заметки по стране
    if (_selectRegion.isEmpty) {
      _provider.clearFilter();
    }

    //если выбран, то применяем фильтр к заметкам
    else {
      _provider.selectRegion(_selectRegion);
    }
  }
}
