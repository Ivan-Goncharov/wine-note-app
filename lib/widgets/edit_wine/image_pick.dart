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

  //путь, который сохранен в заметке на данный момент
  //нам нужна эта переменная для отслеживания,
  //не поставлено ли системное изображение по умолчанию
  late String _imagePath = '';

  @override
  void initState() {
    _imagePath = widget.imagePath;
    //проверяем - было ли выбрано уже изображение и не стоит ли изображение по умолчанию
    if (_imagePath.isNotEmpty && !_imagePath.contains('assets')) {
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
      setState(() {
        image = imageTemp;
        _imagePath = imageGalerry.path;
      });
    } on PlatformException {
      image = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    if (image == null && _imagePath != widget.imagePath) {
      setState(
        () => _imagePath = widget.imagePath,
      );
    }

    //контейнер с изображением, нажатие на который,
    //открывает окно с выбором изображения
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colorScheme.surfaceVariant,
        ),
        width: size.width * 0.9,
        height: size.height * 0.35,
        margin: const EdgeInsets.only(top: 15),

        //если изображение выбрано,
        //то выводим его, если нет, то иконку
        child: Stack(
          children: [
            Center(
              child:
                  //если путь пустой, то выводим на экран иконку выбора изображения
                  _imagePath.isEmpty
                      ? const Icon(Icons.image, size: 120)
                      : _imagePath.contains('assets')
                          ? Image(
                              image: AssetImage(
                                _imagePath,
                              ),
                              width: MediaQuery.of(context).size.height * 0.2,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                image!,
                                height: size.height * 0.32,
                                width: size.width * 0.75,
                                fit: BoxFit.contain,
                              ),
                            ),
            ),
            Positioned(
              top: 215,
              left: 278,
              child: CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.create,
                  color: colorScheme.inverseSurface,
                ),
                backgroundColor: colorScheme.onInverseSurface,
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
            return BodyBottomSheet(
              imagePick: imagePick,
            );
          },
        );
      },
    );
  }
}

//тело в modalBottomSheet
//создает три кнопки: вызов камеры, вызов галери и отмена
class BodyBottomSheet extends StatelessWidget {
  final Function imagePick;
  const BodyBottomSheet({Key? key, required this.imagePick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
