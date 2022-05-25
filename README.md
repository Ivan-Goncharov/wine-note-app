# Дневник сомелье

Приложение для любителей вина, которое позволяет составлять винный погреб прямо в телефоне. 

Создание заметок, их изменение, подсказки ввода, навигация по разделам, поиск заметок.

__Приложение на данный момент успешно протестировано и работает только на платформе Android__

__Google Play__ Store: [Дневник сомелье](https://play.google.com/store/apps/details?id=com.ivanGonch.wineDiary){:target="_blank"}


<img src="assets/github_media/images/Создание заметки.png" alt="drawing" width="200"/> <img src="assets/github_media/images/Навигация.png" alt="drawing" width="200"/> <img src="assets/github_media/images/Подсказки.png" alt="drawing" width="200"/> 

<img src="assets/github_media/images/Поиск.png" alt="drawing" width="200"/>  <img src="assets/github_media/images/Рейтинг.png" alt="drawing" width="200"/> <img src="assets/github_media/images/Быстрый доступ.png" alt="drawing" width="200"/> 

## Используемый стек технологий
### Архитектура 
Вся логика приложения построена через __Provider__. 
### Работа с данными
Все данные записываются локально на устройство для того, чтобы приложением можно было пользоваться оффлайн.  Работа с SQLite осуществляется через плагин [sqflite](https://pub.dev/packages/sqflite).
### Навигация
Навигация производится по rout-маршрутам через __Navigator__. Все маршруты записаны в файле __main__
### Анимация 
Анимированные переходы осуществленны с помощью встроенных средств Flutter. Анимация в приветственном экране приложения построена с помощью пакета [lottie](https://pub.dev/packages/lottie)
### Смена темы
Смены темы прозводится с помощью Provider, а выбор пользователя сохраняется на устройстве, используя [shared_preferences](https://pub.dev/packages/shared_preferences)
### Работа с камерой
Для работы с камерой устройства используется пакет [image_picker](https://pub.dev/packages/image_picker). Обработка выбранных файлов производится через __File__ из библиотеки _dart:io_.

## Примеры работы с приложением

### Видео демонстрация 
[Обзор функций приложения](https://youtu.be/GhL7isuskPo)

## Основные функции в формате GIF с описанием 

### Первичный экран после установки приложения
###
<img src="assets/github_media/gifs/first_screen.gif" alt="gif" width="200"/>

### Cоздание заметки
###
<img src="assets/github_media/gifs/create_note.gif" alt="gif" width="200"/>

### Автоматическое изменение дефолтного изображения
Изображение изменяется, в зависимости от цвета выбранного вина
###
<img src="assets/github_media/gifs/picture_pick.gif" alt="gif" width="200"/>

### Помощь ввода
У разных полей ввода текста, разные помощника ввода. У стран и регионов - подсказку получаем из string_resource. У производителей и поставщиков - берется информация из заметок, которые уже создал пользователь.
###
<img src="assets/github_media/gifs/input_help.gif" alt="gif" width="200"/>

### Страны и регионы
В приложении заложены самые популярные страны и регионы. При выборе одного из параметров - автоматически подставляется или изменяется другой.
###
<img src="assets/github_media/gifs/country.gif" alt="gif" width="200"/>

### Смена темы
###
<img src="assets/github_media/gifs/change_theme.gif" alt="gif" width="200"/>

### Увеличенные элементы интерфейса
Для удобства - элементы, которые теоретически могут содержать большое количество текста - кликабельны и открывается полное описание
###
<img src="assets/github_media/gifs/image_resize.gif" alt="gif" width="200"/>

### Тап по информации в вине
По тапу на страну/производителя/регион/цвет/сорт можно перейти на список всех заметок, связанных с этим разделом
###
<img src="assets/github_media/gifs/taps_navigator.gif" alt="gif" width="200"/>

### Поиск заметок
Поиск производится по всем полям во всех заметках одновременно
###
<img src="assets/github_media/gifs/search.gif" alt="gif" width="200"/>

### Фильтрация и сортировка
Доступны несколько видов сортировки и фильтрации заметок
###
<img src="assets/github_media/gifs/filter.gif" alt="gif" width="200"/>

### Навигация по заметкам
Навигация производится по следующим разделам: Страны, Производители, Сорта
###
<img src="assets/github_media/gifs/navigation.gif" alt="gif" width="200"/>

## Установка и работа с приложением 

Приложение протестировано и работает только на базе Android.
Для запуска необходим установленный Flutter, VS Code или Android Studio, эмулятор Android девайса или физическое устройство.
### Последовательность действий
1. Клонирование репозитория с помощью команды `git clone` в терминале.
2. Установка всех зависимостей _pubspec.yaml_ с помощью команды `flutter pub get`
3. Запуск приложения:
 - Либо через компьютер с подключенным физическим устройством или эмулятором. Выполняем в корне приложения команду `flutter run -d <DEVICE-ID>`
 - Либо в корне приложения собираем apk, вызвав команду `flutter build apk`. Файл устанавливаем на физическое устройство с Android OC. 
