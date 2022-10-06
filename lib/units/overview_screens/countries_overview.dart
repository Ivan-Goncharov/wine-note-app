import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_database_provider.dart';
import '../../string_resourses.dart';
import '../../widgets/overview_widget/item_overtview_country.dart';
import '../../widgets/system_widget/app_bar.dart';

//Экран с обзором заметок по странам
class CountriesOverview extends StatefulWidget {
  const CountriesOverview({Key? key}) : super(key: key);

  @override
  State<CountriesOverview> createState() => _CountriesOverviewState();
}

class _CountriesOverviewState extends State<CountriesOverview> {
  // провайдер для доступа к записям
  late WineDatabaseProvider _provider;

  //список стран, которые мы заполним в дальнейшем
  List<Map<String, dynamic>> _counriesList = [];

  //переменная для того, чтобы единожды инициализировать данные, связанные с контекстом
  bool _isInit = false;

  //инициализируем провайдер
  //получаем список стран, которые у нас представлены в заметках
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _provider = Provider.of<WineDatabaseProvider>(context, listen: false);
      _counriesList = Country.userCountriesList(_provider.wineList);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: 'Страны'),
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            //выводим информацию по каждой стране
            return ItemOverviewCountry(
              country: _counriesList[index],
            );
          },
          itemCount: _counriesList.length,
        ),
      ),
    );
  }
}
