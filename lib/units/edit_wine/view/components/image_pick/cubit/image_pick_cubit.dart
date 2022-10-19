import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_pick_state.dart';

class ImagePickCubit extends Cubit<ImagePickState> {
  ImagePickCubit() : super(ImagePickInitial());
  File? imageFile;

  void initial(String imageUrl) {
    if (imageUrl.isEmpty) {
      emit(ImagePickEmptyState());
    } else if (imageUrl.contains('asset')) {
      emit(ImagePickAssetState(imageUrl));
    } else {
      imageFile = File(imageUrl);
      emit(ImagePickUserPhotoState(imageFile!));
    }
  }

  /// Метод для выбора изображения
  /// Принимаем тип источника, либо галерея, либо камера
  Future<void> imagePick(ImageSource imageSource) async {
    // Вызываем метод для выбора изображения
    final imageGalerry = await ImagePicker().pickImage(source: imageSource);

    // Если пользователь ничего не выбрал, то выходим из метода
    if (imageGalerry == null) return;

    imageFile = File(imageGalerry.path);

    // Сперва event об успешном выборе фото
    emit(ImagePickSuccefulState(imageFile!));
    
    // Затем event для перестроения виджета выбора фотографии
    emit(ImagePickUserPhotoState(imageFile!));
  }
}
