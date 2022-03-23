//класс для хранения ресурсов
class Country {
  static List<Map<String, String>> countryList = [
    {'country': 'Австралия', 'svg': 'assets/images/country_flags/au.svg'},
    {'country': 'Австрия', 'svg': 'assets/images/country_flags/at.svg'},
    {'country': 'Болгария', 'svg': 'assets/images/country_flags/bg.svg'},
    {'country': 'Бразилия', 'svg': 'assets/images/country_flags/br.svg'},
    {'country': 'Швейцария', 'svg': 'assets/images/country_flags/ch.svg'},
    {'country': 'Чили', 'svg': 'assets/images/country_flags/cl.svg'},
    {'country': 'Китай', 'svg': 'assets/images/country_flags/cn.svg'},
    {'country': 'Чехия', 'svg': 'assets/images/country_flags/cz.svg'},
    {'country': 'Германия', 'svg': 'assets/images/country_flags/de.svg'},
    {'country': "Испания", 'svg': 'assets/images/country_flags/es.svg'},
    {'country': 'Франция', 'svg': 'assets/images/country_flags/fr.svg'},
    {'country': 'Грузия', 'svg': 'assets/images/country_flags/ge.svg'},
    {'country': 'Греция', 'svg': 'assets/images/country_flags/gr.svg'},
    {'country': 'Венгрия', 'svg': 'assets/images/country_flags/hu.svg'},
    {'country': 'Италия', 'svg': 'assets/images/country_flags/it.svg'},
    {'country': 'Япония', 'svg': 'assets/images/country_flags/jp.svg'},
    {'country': 'Молдавия', 'svg': 'assets/images/country_flags/md.svg'},
    {'country': 'Македония', 'svg': 'assets/images/country_flags/me.svg'},
    {'country': 'Новая Зеландия', 'svg': 'assets/images/country_flags/nz.svg'},
    {'country': 'Перу', 'svg': 'assets/images/country_flags/pe.svg'},
    {'country': 'Португалия', 'svg': 'assets/images/country_flags/pt.svg'},
    {'country': 'Румыния', 'svg': 'assets/images/country_flags/ro.svg'},
    {'country': 'Россия', 'svg': 'assets/images/country_flags/ru.svg'},
    {'country': 'США', 'svg': 'assets/images/country_flags/us.svg'},
    {'country': 'ЮАР', 'svg': 'assets/images/country_flags/za.svg'},
    {'country': 'Украина', 'svg': 'assets/images/country_flags/ua.svg'},
  ];

  static List<Map<String, dynamic>> regionList = [
    {'country': '', 'region': []},
    {
      'country': 'Австралия',
      'region': [
        'Долина Баросса',
        'Долина Иден',
        'Долина Клер',
        'Долина Макларен',
        'Кунаворра',
        'Аделаидские Холмы',
        'Греат Соусерн',
        'Маргарет Ривер',
        'Новый Южный Уэльс',
        'Виктория',
        'Тасмания',
        'Квинсленд'
      ]
    },
    {
      'country': 'Австрия',
      'region': [
        'Нижняя Австрия',
        'Вена',
        'Бургенланд',
        'Штирия',
      ]
    },
    {
      'country': 'Болгария',
      'region': [
        'Дунайская равнина',
        'Фракийская низменность',
        'Причерноморье',
        'Долина реки Струма',
        'Долина Роз'
      ]
    },
    {
      'country': 'Бразилия',
      'region': [
        'Рио-Гранде-дель-Сур',
        'Нордесте',
        'Вале-де-Сан-Франсиско',
      ]
    },
    {
      'country': 'Швейцария',
      'region': [
        'Вале',
        'Во',
        'Женева',
        'Тичино',
        'Аргау',
        'Цюрих',
        'Шаффхаузен',
        'Люцерн',
      ]
    },
    {
      'country': 'Чили',
      'region': [
        'Долина Эльки',
        'Долина Лимари',
        'Долина Чоапа',
        'Долина Аконкагуа',
        'Долина Касабланка',
        'Долина Сан Антонио',
        'Долина Майпо',
        'Качапоалская долина',
        'Долина Колчагуа',
        'Долина Курико',
        'Долина Мауле',
        'Долина Итата',
        'Долина Био Био',
        'Долина Маллеко',
      ],
    },
    {
      'country': 'Китай',
      'region': [
        'Провинция Шаньдун',
        'Провинция Хэбэй',
        'Пекин',
        'Тяньцзинь',
        'Провинция Шаньси',
        'Шэньси́',
        'Цзили́нь',
        'Ляонин',
      ],
    },
  ];

  static List<Map<String, String>> searchCountry(String item) {
    List<Map<String, String>> list = [];

    for (var element in countryList) {
      if (element['country']!.toLowerCase().contains(item.toLowerCase())) {
        list.add(element);
      }
    }
    return list;
  }
}
