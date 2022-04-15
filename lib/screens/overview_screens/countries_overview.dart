import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../../models/wine_list_provider.dart';
import '../../string_resourses.dart';
import '../../widgets/overview_widget/item_overtview_country.dart';

//Экран с обзором заметок по странам
class CountriesOverview extends StatefulWidget {
  static const routName = './countryOverview';
  const CountriesOverview({Key? key}) : super(key: key);

  @override
  State<CountriesOverview> createState() => _CountriesOverviewState();
}

class _CountriesOverviewState extends State<CountriesOverview> {
  // провайдер для доступа к записям
  late WineListProvider _provider;

  //список стран, которые мы заполним в дальнейшем
  List<Map<String, dynamic>> _counriesList = [];

  //переменная для того, чтобы единожды инициализировать данные, связанные с контекстом
  bool _isInit = false;

  //инициализируем провайдер
  //получаем список стран, которые у нас представлены в заметках
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _provider = Provider.of<WineListProvider>(context, listen: false);
      _counriesList = Country.userCountriesList(_provider.wineList);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(title: 'Страны'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ItemOverviewCountry(
              country: _counriesList[index],
              size: size,
              colorScheme: colorScheme,
            );
          },
          itemCount: _counriesList.length,
        ),
      ),
    );
  }
}
