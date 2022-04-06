//класс для хранения ресурсов
import 'models/wine_item.dart';

class Country {
  static final List<Map<String, dynamic>> countryList = [
    {
      'country': 'Австралия',
      'svg': 'assets/images/country_flags/au.svg',
      'count': 1
    },
    {
      'country': 'Австрия',
      'svg': 'assets/images/country_flags/at.svg',
      'count': 1
    },
    {
      'country': 'Болгария',
      'svg': 'assets/images/country_flags/bg.svg',
      'count': 1
    },
    {
      'country': 'Бразилия',
      'svg': 'assets/images/country_flags/br.svg',
      'count': 1
    },
    {
      'country': 'Швейцария',
      'svg': 'assets/images/country_flags/ch.svg',
      'count': 1
    },
    {
      'country': 'Чили',
      'svg': 'assets/images/country_flags/cl.svg',
      'count': 1
    },
    {
      'country': 'Китай',
      'svg': 'assets/images/country_flags/cn.svg',
      'count': 1
    },
    {
      'country': 'Чехия',
      'svg': 'assets/images/country_flags/cz.svg',
      'count': 1
    },
    {
      'country': 'Германия',
      'svg': 'assets/images/country_flags/de.svg',
      'count': 1
    },
    {
      'country': "Испания",
      'svg': 'assets/images/country_flags/es.svg',
      'count': 1
    },
    {
      'country': 'Франция',
      'svg': 'assets/images/country_flags/fr.svg',
      'count': 1
    },
    {
      'country': 'Грузия',
      'svg': 'assets/images/country_flags/ge.svg',
      'count': 1
    },
    {
      'country': 'Греция',
      'svg': 'assets/images/country_flags/gr.svg',
      'count': 1
    },
    {
      'country': 'Венгрия',
      'svg': 'assets/images/country_flags/hu.svg',
      'count': 1
    },
    {
      'country': 'Италия',
      'svg': 'assets/images/country_flags/it.svg',
      'count': 1
    },
    {
      'country': 'Япония',
      'svg': 'assets/images/country_flags/jp.svg',
      'count': 1
    },
    {
      'country': 'Молдавия',
      'svg': 'assets/images/country_flags/md.svg',
      'count': 1
    },
    {
      'country': 'Македония',
      'svg': 'assets/images/country_flags/me.svg',
      'count': 1
    },
    {
      'country': 'Новая Зеландия',
      'svg': 'assets/images/country_flags/nz.svg',
      'count': 1
    },
    {
      'country': 'Перу',
      'svg': 'assets/images/country_flags/pe.svg',
      'count': 1
    },
    {
      'country': 'Португалия',
      'svg': 'assets/images/country_flags/pt.svg',
      'count': 1
    },
    {
      'country': 'Румыния',
      'svg': 'assets/images/country_flags/ro.svg',
      'count': 1
    },
    {
      'country': 'Россия',
      'svg': 'assets/images/country_flags/ru.svg',
      'count': 1
    },
    {'country': 'США', 'svg': 'assets/images/country_flags/us.svg', 'count': 1},
    {'country': 'ЮАР', 'svg': 'assets/images/country_flags/za.svg', 'count': 1},
  ];

  static final List<Map<String, dynamic>> regionList = [
    {
      'country': 'ЮАР',
      'region': [
        'Стелленбош',
        'Паарль',
        'Хемель-эн-Аарде',
        'Элим',
        'Элгин',
        'Робертсон',
        'Свартленд',
        'Констанция'
            'Франшхук'
      ],
    },
    {
      'country': 'США',
      'region': [
        'Калифорния',
        'Орегон',
        'Вашингтон',
        'Нью-Йорк',
        'Вирджиния',
        'Техас',
      ],
    },
    {
      'country': 'Россия',
      'region': [
        'Краснодарский край',
        'Ставропольский край',
        'Дагестан'
            'Чечня',
        'Крым'
      ],
    },
    {
      'country': 'Румыния',
      'region': [
        'Южные Карпаты',
        'Восточные Карпаты',
        'Трансильвания',
        'Добруджа'
      ],
    },
    {
      'country': 'Португалия',
      'region': [
        'Винью Верде',
        'Байррада',
        'Дау',
        'Дору',
        'Алентежу',
        'Лиссабон',
        'Сетубаль',
        'Мадейра',
        'Азорские острова'
      ],
    },
    {
      'country': 'Перу',
      'region': [
        'Ика',
        'Лима',
        'Куско',
        'Арекипа',
        'Такна',
      ],
    },
    {
      'country': 'Новая Зеландия',
      'region': [
        'Гисборн',
        'Хокс-Бей',
        'Мальборо',
        'Окленд',
        'Вайкато',
        'Вайрапа',
        'Нельсон',
        'Кентербери',
        'Отаго'
      ],
    },
    {
      'country': 'Македония',
      'region': [
        'Повардарье',
        'Пелагония-Полог',
        'Пчиня-Осогово',
      ],
    },
    {
      'country': 'Молдавия',
      'region': ['Кодру', 'Бэлць', 'Приднестровск', 'Кагул'],
    },
    {
      'country': 'Япония',
      'region': [
        'Хоккайдо',
        'Ямагата',
        'Яманаси',
        'Фукуоку',
        'Нагано',
        'Аити',
        'Окаяма',
        'Ниигата'
      ],
    },
    {
      'country': 'Италия',
      'region': [
        'Пьемонт',
        'Тоскана',
        'Венето',
        'Южный Тироль',
        'Сицилия',
        'Лацио',
        'Умбрия',
        'Ломбардия',
        'Валле дАоста',
        'Трентино-Альто-Адидже',
        'Фриули-Венеция-Джулия',
        'Венето',
        'Лигурия',
        'Эмилия-Романья',
        'Марке',
        'Абруццо',
        'Кампания',
        'Молизе',
        'Апулия',
        'Сардиния',
        'Калабрия',
        'Базиликата'
      ],
    },
    {
      'country': 'Венгрия',
      'region': [
        'Токай',
        'Бюкк',
        'Эгер',
        'Матра',
        'Шопрон',
        'Паннонхалма',
        'Несмей',
        'Мор',
        'Этьек-Буда',
        'Шомло',
        'Надь-Шомло',
        'Виллань',
        'Сексард',
        'Печ',
        'Тольна',
        'Куншаг',
        'Чонград',
        'Хайош-Байя',
      ],
    },
    {
      'country': 'Греция',
      'region': [
        'Полуостров Пелопоннес',
        'Крит',
        'Центральная Греция',
        'остров Эвия',
        'Македония',
        'Фракия',
        'Фессалия',
        'Ионические острова',
        'Острова Эгейского моря',
        'Острова Додеканиса',
        'Эпир'
      ],
    },
    {
      'country': 'Грузия',
      'region': [
        'Кахети',
        'Имерити',
        'Картли',
        'Аджария',
        'Рача-Лечхуми',
        'Месхети',
      ],
    },
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
    {
      'country': 'Чехия',
      'region': ['Моравия', 'Богемия'],
    },
    {
      'country': 'Германия',
      'region': [
        'АР',
        'Баден',
        'Вюртемберг',
        'Гессенская горная дорога',
        'Заале-Унструт',
        'Мозель',
        'Наэ',
        'Пфальц',
        'Рейнгау',
        'Рейнгессен',
        'Саксония',
        'Средний Рейн',
        'Франкония',
      ],
    },
    {
      'country': 'Испания',
      'region': [
        'Андалусия',
        'Арагон',
        'Валенсия',
        'Галисия',
        'Кастилия Леон',
        'Кастилия Ла Манча',
        'Каталония',
        'Мадрид',
        'Мурсия',
        'Наварра',
        'Риас Байшас',
        'Риоха',
        'Страна Басков',
        'Херес де ла Фронтера'
      ],
    },
    {
      'country': 'Франция',
      'region': [
        'Шампань',
        'Эльзас',
        'Долина реки Луары',
        'Шабли',
        'Кот д’Ор',
        'Кот Шалонез',
        'Маконне',
        'Жюра',
        'Бордо',
        'Долина Роны'
            'Лангедок-Руссильон',
        'Прованс',
        'Каор',
      ],
    },
  ];

  static final List<String> grapeVariety = [
    'Айрен',
    'Александроули',
    'Алиготе',
    'Альбильо',
    'Альвариньо',
    'Ансоника',
    'Арнеис',
    'Бабич',
    'Барбера',
    'Бастардо',
    'Бианка',
    'Бобал',
    'Бовале Сардо',
    'Вердельо',
    'Вердехо',
    'Вердиккио',
    'Верментино',
    'Верначча',
    'Вионье',
    'Воскеат',
    'Вранац',
    'Гаме',
    'Гарганега',
    'Гренаш Нуар',
    'Гевюрцтраминер',
    'Глера',
    'Голубок',
    'Горули Мцване',
    'Грасиано',
    'Морастель',
    'Грекетто',
    'Гарнача Бланка',
    'Дольчетто',
    'Каберне Совиньон',
    'Каберне Фран',
    'Канайоло',
    'Кариньян',
    'Карменер',
    'Катарратто',
    'Кахет',
    'Кефесия',
    'Клерет',
    'Кокур',
    'Коломбар',
    'Колорино',
    'Корвина',
    'Корвиноне',
    'Кортезе',
    'Красностоп',
    'Ламбруско',
    'Макабео',
    'Мальбек',
    'Мальвазия',
    'Мальвазия ди Кандия',
    'Мальвазия Нера',
    'Мальвазия Фина',
    'Маммоло',
    'Марцемино',
    'Мерло',
    'Мерсегера',
    'Мозак',
    'Молинара',
    'Моника',
    'Монтепульчано',
    'Муджуретули',
    'Мурведр',
    'Мускадель',
    'Мускат',
    'Мюллер-Тургау',
    'Неббиоло',
    'Негроамаро',
    'Нерелло Маскалезе',
    'Неро дАвола',
    'Одесский Черный',
    'Паломино Фино',
    'Парельяда',
    'Парралета',
    'Педро Хименес',
    'Пекорино',
    'Перриконе',
    'Пино Блан',
    'Пино Гри',
    'Пино Нуар',
    'Пинотаж',
    'Плавац Мали',
    'Португизер',
    'Примитиво',
    'Пти Вердо ',
    'Рефоско',
    'Рислинг',
    'Ркацители',
    'Рондинелла',
    'Санджовезе',
    'Саперави',
    'Семильон',
    'Серсиаль',
    'Сильванер',
    'Сира',
    'Совиньон Блан',
    'Сэнсо',
    'Темпранильо',
    'Террано',
    'Тинта Баррока',
    'Тинта Негра Моле',
    'Тинто Као',
    'Треббьяно',
    'Тринкадейра',
    'Турбат',
    'Турига Насьональ',
    'Турига Франка',
    'Фернао Пирес',
    'Фурминт',
    'Цвайгельт',
    'Цоликоури',
    'Чарелло',
    'Чильеджоло',
    'Шабаш',
    'Шардоне',
    'Шенен Блан',
    'Эким Кара',
    ''
  ];

  static String fetchSvgPath(String countryName) {
    String path = '';
    for (var element in countryList) {
      if (element['country'] == countryName) {
        path = element['svg']!;
        break;
      }
    }
    return path;
  }

  static String countryName(String region) {
    String nameCountry = '';
    for (var element in regionList) {
      if ((element['region'] as List<String>).contains(region)) {
        nameCountry = element['country'];
        break;
      }
    }
    return nameCountry;
  }

  static List<String> regionsOfCountry(String countryName) {
    List<String> list = [];
    Map<String, dynamic> map = {};
    for (var element in regionList) {
      if (element['country'] == countryName) {
        map = element;
      }
    }

    if (map.isNotEmpty) {
      list = map['region'];
    } else {
      for (var element in regionList) {
        list.addAll(element['region']);
      }
    }

    return list;
  }

  //метод для создания списка стран, которые уже используются в заметках
  static List<Map<String, dynamic>> userCountriesList(List<WineItem> notes) {
    List<Map<String, dynamic>> list = [];

    //список стран, которые уже добавили,
    // чтобы не добавить страну дважды
    List<String> selectCountries = [];

    //проходимся по списку заметок
    for (var note in notes) {
      //если такую страну уже добавляли, то увличиваем счетчик ее, для того,
      // чтобы затем вывести список по популярноcти стран
      if (selectCountries.contains(note.country.toLowerCase())) {
        //получаем индекс заметки
        final index = list.indexWhere(
          (element) =>
              (element['country'] as String).toLowerCase() ==
              note.country.toLowerCase(),
        );

        list[index]['count'] += 1;
      }

      //если еще не добавляли эту страну в список, то добавляем
      else {
        selectCountries.add(note.country.toLowerCase());
        //ищем совпадение в списке стран, чтобы добавить еще и флаг
        //если нет совпадения, то создаем сами карту;
        final result = countryList.firstWhere(
          (element) => element['country'] == note.country,
          orElse: () => {
            'country': note.country,
            'svg': '',
            'count': 1,
          },
        );

        result['count'] = 1;
        list.add(result);
      }
    }

    //сортируем список по количеству вин в заметках
    list.sort(
      ((a, b) => (b['count'] as int).compareTo(a['count'] as int)),
    );

    return list;
  }
}

enum SearchType {
  countryType,
  regionType,
}
