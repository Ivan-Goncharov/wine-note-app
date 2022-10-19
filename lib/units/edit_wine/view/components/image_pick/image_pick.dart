
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/edit_wine/view/components/image_pick/cubit/image_pick_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

//виджет для выбора изображения для вывода на экран
class WineImagePick extends StatelessWidget {
  //принимаем аргументы - путь к изображению, если оно уже выбрано
  //и функция для сохранения изображения в заметке
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
      listenWhen: (previous, current) => current is ImagePickSuccefulState,
      listener: (context, state) {
        if (state is ImagePickSuccefulState) {
          // BlocProvider.of<EditWineBloc>(context)
          //     .add(EditWineSaveImage(state.imagePath));
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

          //если изображение выбрано,
          //то выводим его, если нет, то иконку
          child: Stack(
            children: [
              Center(
                child: BlocBuilder<ImagePickCubit, ImagePickState>(
                  buildWhen: (previous, current) =>
                      previous != current && current is! ImagePickSuccefulState,
                  builder: (context, state) {
                    if (state is ImagePickEmptyState) {
                      return const Icon(Icons.image, size: 120);
                    } else if (state is ImagePickAssetState) {
                      return Image(
                        image: AssetImage(
                          state.imageUrl,
                        ),
                        width: MediaQuery.of(context).size.height * 0.2,
                      );
                    } else if (state is ImagePickUserPhotoState) {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //камера
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

        //галерея
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
