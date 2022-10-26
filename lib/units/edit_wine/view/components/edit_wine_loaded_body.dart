import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/units/components/edit_wine_chapter/item_chapter_edit.dart';
import 'package:flutter_my_wine_app/units/components/image_pick/image_pick.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_my_wine_app/units/edit_wine/view/components/wine_edit_general_info.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/edit_save_dialog.dart';

class EditWineLoadedBody extends StatelessWidget {
  final EditWineLoadedState state;
  const EditWineLoadedBody({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => EditWineDialog(
              saveNote: () => BlocProvider.of<EditWineBloc>(context)
                  .add(EditWineSaveEvent()),
            ),
          ),
        ),
        title: Text(
          state.screenState.isChange ? 'Изменить заметку' : 'Добавить заметку',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              () => BlocProvider.of<EditWineBloc>(context)
                  .add(EditWineSaveEvent());
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: GlobalKey(),
            child: SingleChildScrollView(
              //при прокручивании полей убираем клавиатуру
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  // Выбор изображения для вина.
                  WineImagePick(imagePath: state.editWineModel.imageUrl),

                  // Глава об общей информации.
                  ItemChapterEdit(
                    title: 'Общая информация о вине',
                    changeVisible: () {
                      BlocProvider.of<EditWineBloc>(context)
                          .add(ChangeVisibleGeneralInfoEvent());
                    },
                    initialVisible: state.screenState.isVisGeneralInfo,
                  ),

                  // Visible поля для ввода общей информации о вине.
                  WineEditGeneralInfo(state: state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

                  
                  // 
                  // const Divider(height: 1),

                  // //Основные характеристики
                  // ItemChapterEdit(
                  //   title: 'Основные характеристики',
                  //   changeVisible: () {
                  //     setState(() => _isVisMainFeatures = !_isVisMainFeatures);
                  //   },
                  // ),
                  // Visibility(
                  //   visible: _isVisMainFeatures,
                  //   child: Column(
                  //     children: [
                  //       // указываем цвета вина
                  //       DropDownColor(
                  //         wineColor: _note.wineColors,
                  //         saveColor: _changeWineColor,
                  //       ),

                  //       //Сорт винограда
                  //       TextInputWithHint(
                  //         fieldType: WineNoteFields.grapeVariety,
                  //         changeData: _changeGrapeSort,
                  //         data: _note.grapeVariety,
                  //         hintText: 'Выберите сорт винограда',
                  //         title: 'Сорт винограда',
                  //       ),

                  //       //алкоголь
                  //       TextFieldInput(
                  //         //если процент алкоголя не указан, то передаем пустую строку
                  //         initialValue: _note.alcoPercent == 0.0
                  //             ? ''
                  //             : _note.alcoPercent.toString(),

                  //         //сохраняем данные
                  //         changeNote: (value) {
                  //           double wineAlco = 0.0;

                  //           //если пользователь ввел вместо точки - запятую,
                  //           //меняем запятую на точку
                  //           if (value.isEmpty) {
                  //             wineAlco = 0.0;
                  //           } else if (value.contains(',')) {
                  //             wineAlco =
                  //                 double.parse(value.replaceAll(',', '.'));
                  //           } else {
                  //             wineAlco = double.parse(value);
                  //           }

                  //           if (wineAlco > 100) wineAlco = 100;
                  //           //парсимм значение в double и сохраняем в заметку
                  //           _note = _note.copyWith(alcoPercent: wineAlco);
                  //         },
                  //         fieldAction: TextInputAction.done,
                  //         hintText: 'Укажите процент алкоголя',
                  //         lableText: 'Алкоголь',
                  //         keyboardType: TextInputType.number,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Divider(height: 1),

                  // //дегустационные впечатления
                  // ItemChapterEdit(
                  //   title: 'Дегустационные впечатления',
                  //   changeVisible: () {
                  //     setState(() => _isVisTasting = !_isVisTasting);
                  //   },
                  // ),
                  // Visibility(
                  //   visible: _isVisTasting,
                  //   child: Column(
                  //     children: [
                  //       //Аромат вина
                  //       TextFieldInput(
                  //         initialValue: _note.aroma,
                  //         lableText: 'Аромат',
                  //         hintText: 'Опишите аромат вина',
                  //         changeNote: (value) {
                  //           _note = _note.copyWith(aroma: value);
                  //         },
                  //         fieldAction: TextInputAction.next,
                  //       ),

                  //       //Вкус вина
                  //       TextFieldInput(
                  //         initialValue: _note.taste,
                  //         lableText: 'Вкус',
                  //         hintText: 'Опишите вкус вина',
                  //         changeNote: (value) {
                  //           _note = _note.copyWith(taste: value);
                  //         },
                  //         fieldAction: TextInputAction.next,
                  //       ),

                  //       //Комментарий по заметке
                  //       TextFieldInput(
                  //         initialValue: _note.comment,
                  //         lableText: 'Комментарий',
                  //         hintText: 'Заметки о вине',
                  //         changeNote: (value) {
                  //           _note = _note.copyWith(comment: value);
                  //         },
                  //         fieldAction: TextInputAction.done,
                  //       ),

                  //       // рейтинг вина
                  //       TextFieldRating(
                  //         rating: WineRating(
                  //           ratingAppearance: _note.ratingAppearance,
                  //           ratingAroma: _note.ratingAroma,
                  //           ratingTaste: _note.ratingTaste,
                  //         ),
                  //         saveRating: (newRating) {
                  //           if (newRating is WineRating) {
                  //             _note = _note.copyWith(
                  //               ratingAroma: newRating.ratingAroma,
                  //               ratingTaste: newRating.ratingTaste,
                  //               ratingAppearance: newRating.ratingAppearance,
                  //             );
                  //           }
                  //         },
                  //       )
