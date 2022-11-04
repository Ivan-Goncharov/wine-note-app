import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/components/image_pick/cubit/image_pick_cubit.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// Виджет для выбора изображения для вывода на экран
class WineImagePick extends StatelessWidget {
  // Путь к изображению, если оно уже выбрано
  final String imagePath;
  const WineImagePick({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagePickCubit>(
      create: (_) => getIt<ImagePickCubit>()..initial(imagePath),
      child: const _WineImagePickBody(),
    );
  }
}

class _WineImagePickBody extends StatelessWidget {
  const _WineImagePickBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<ImagePickCubit, ImagePickState>(
      // Прослушивание срабатывает только в случае успешного выбора изображения
      listenWhen: (previous, current) => current is ImagePickSuccefulState,
      listener: (context, state) {
        // Сохраняем результат в EditBloc
        if (state is ImagePickSuccefulState) {
          BlocProvider.of<EditWineBloc>(context)
              .add(EditWineSaveImage(state.image));
        }
      },
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: colorScheme.surfaceVariant,
          ),
          width: size.width * 0.9,
          height: size.height * 0.35,
          margin: const EdgeInsets.only(top: 15),
          child: Stack(
            children: [
              Center(
                child: BlocBuilder<ImagePickCubit, ImagePickState>(
                  buildWhen: (previous, current) =>
                      previous != current && current is! ImagePickSuccefulState,
                  builder: (context, state) {
                    if (state is ImagePickEmptyState) {
                      // Изображение еще не выбрано.
                      return const Icon(Icons.image, size: 120);
                    } else if (state is ImagePickAssetState) {
                      // Выбрано дефолтное изображение.
                      return Image(
                        image: AssetImage(
                          state.imageUrl,
                        ),
                        width: MediaQuery.of(context).size.height * 0.2,
                      );
                    } else if (state is ImagePickUserPhotoState) {
                      // Выбрано изображение пользовательское.
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          state.image,
                          height: size.height * 0.32,
                          width: size.width * 0.75,
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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
        // При тапе выпадает меню с выбором действйи
        onTap: () {
          showModalBottomSheet(
            isDismissible: true,
            context: context,
            builder: (_) {
              return BodyBottomSheet(
                imagePick: BlocProvider.of<ImagePickCubit>(context).imagePick,
              );
            },
            
          );
        },
      ),
    );
  }
}

//тело в modalBottomSheet
//создает три кнопки: вызов камеры, вызов галери и отмена
class BodyBottomSheet extends StatelessWidget {
  final Function(ImageSource imageSource) imagePick;
  const BodyBottomSheet({Key? key, required this.imagePick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Камера
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: const Text('Камера'),
            onTap: () async {
              if (await Permission.camera.request().isGranted) {
                imagePick(ImageSource.camera);
              }
              Navigator.pop(context);
            },
          ),

          const _CustomDivider(),

          // Галерея
          ListTile(
            leading: const Icon(Icons.image_outlined),
            title: const Text('Галерея'),
            onTap: () async {
              if (await Permission.mediaLibrary.request().isGranted) {
                imagePick(ImageSource.gallery);
              }
              Navigator.pop(context);
            },
          ),

          const _CustomDivider(),

          /// Отмена
          ListTile(
            leading: const Icon(Icons.cancel_outlined),
            title: const Text('Отмена'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 2,
      indent: 16,
      endIndent: 16,
    );
  }
}
