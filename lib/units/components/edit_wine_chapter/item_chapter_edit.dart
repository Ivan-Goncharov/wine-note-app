//виджет заголовка одного раздела
//по тапу на заголовок, открываются поля ввода
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/components/edit_wine_chapter/cubit/edit_wine_chapter_cubit.dart';

class ItemChapterEdit extends StatelessWidget {
  // Заголовок
  final String title;

  // Функция  открытия списка
  final void Function() changeVisible;

  final bool initialVisible;
  const ItemChapterEdit({
    Key? key,
    required this.title,
    required this.changeVisible,
    required this.initialVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditWineChapterCubit>(
      create: (_) => getIt<EditWineChapterCubit>()..initial(initialVisible),
      child: _EditWineChapterBody(title: title, changeVisible: changeVisible),
    );
  }
}

class _EditWineChapterBody extends StatelessWidget {
  // Заголовок
  final String title;

  // Функция  открытия списка
  final void Function() changeVisible;

  const _EditWineChapterBody(
      {Key? key, required this.title, required this.changeVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        // По нажатию - изменяем состояние виджета
        BlocProvider.of<EditWineChapterCubit>(context).changeStatus();
        // Вызываем функцию открытия скрытого списка
        changeVisible();
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        color: _colors.surface,
        height: MediaQuery.of(context).size.height * 0.05,
        child: BlocBuilder<EditWineChapterCubit, EditWineChapterState>(
          builder: (context, state) {
            if (state is EditWineChapterChangeState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight:
                            state.isOpen ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 20,
                        color: state.isOpen
                            ? _colors.onPrimaryContainer
                            : _colors.onSurface,
                      ),
                    ),
                  ),
                  Icon(
                    state.isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 30,
                    color: state.isOpen
                        ? _colors.onPrimaryContainer
                        : _colors.onSurface,
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
