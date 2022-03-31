import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

//виджет для выбора изображения для вывода на экран
class WineImagePick extends StatefulWidget {
  //принимаем аргументы - путь к изображению, если оно уже выбрано
  //и функция для сохранения изображения в заметке
  final String imagePath;
  final Function function;
  const WineImagePick(
      {Key? key, required this.imagePath, required this.function})
      : super(key: key);
  @override
  State<WineImagePick> createState() => _WineImagePickState();
}

class _WineImagePickState extends State<WineImagePick> {
//переменная для хранения выбранного изображения
  File? image;

  @override
  void initState() {
    if (widget.imagePath.isNotEmpty) {
      image = File(widget.imagePath);
    }
    super.initState();
  }

  //метод для выбора изображения
  //принимаем тип источника, либо галерея, либо камера
  Future<void> imagePick(ImageSource source) async {
    try {
      //вызываем метод для выбора изображения
      final imageGalerry = await ImagePicker().pickImage(source: source);

      //если пользователь ничего не выбрал, то выходим из метода
      if (imageGalerry == null) return;

      //вызываем функцию для сохранения нового пути к изображению в заметке
      widget.function(imageGalerry.path);

      //получаем файл, выбранного изображения
      final imageTemp = File(imageGalerry.path);

      //присваиваем новое значение переменной, которая хранит изображение
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Ошибка в выборе изображения $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    //контейнер с изображением, нажатие на который,
    //открывает окно с выбором изображения
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colorScheme.surfaceVariant,
        ),
        width: size.width * 0.85,
        height: size.height * 0.35,
        margin: const EdgeInsets.only(top: 15),

        //если изображение выбрано,
        //то выводим его, если нет, то иконку
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? const Icon(Icons.image, size: 120)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      image!,
                      height: size.height * 0.32,
                      fit: BoxFit.contain,
                    ),
                  ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) {
            return createModalBottomBody();
          },
        );
      },
    );
  }

  //метод для создания тела в modalBottomSheet
  //создает три кнопки: вызов камеры, вызов галери и отмена
  Column createModalBottomBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //камера
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text('Камера'),
          onTap: () {
            imagePick(ImageSource.camera);
            Navigator.pop(context);
          },
        ),

        //галерея
        ListTile(
          leading: const Icon(Icons.image_outlined),
          title: const Text('Галерея'),
          onTap: () {
            imagePick(ImageSource.gallery);
            Navigator.pop(context);
          },
        ),

        //отмена
        ListTile(
          leading: const Icon(Icons.cancel_outlined),
          title: const Text('Отмена'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
