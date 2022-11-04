import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/constants/string_resources.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/components/edit_wine_chapter/item_chapter_edit.dart';
import 'package:flutter_my_wine_app/units/components/manuf_field/view/manuf_field.dart';
import 'package:flutter_my_wine_app/units/components/manuf_text_field/view/manuf_text_input.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_my_wine_app/units/edit_wine/view/components/general_info/cubit/general_info_edit_cubit.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/text_field_hint.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/text_field_container.dart';

class GeneralInfoWineEdit extends StatelessWidget {
  const GeneralInfoWineEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GeneralInfoEditCubit>(
      create: (_) => getIt<GeneralInfoEditCubit>()..initial(),
      child: const _GeneralInfoBody(),
    );
  }
}

class _GeneralInfoBody extends StatelessWidget {
  const _GeneralInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editWineState =
        (BlocProvider.of<EditWineBloc>(context).state as EditWineLoadedState);
    return BlocBuilder<GeneralInfoEditCubit, GeneralInfoEditState>(
      builder: (context, state) {
        if (state is GeneralInfoEditIsOpenState) {
          return Column(
            children: [
              // Глава об общей информации.
              ItemChapterEdit(
                title: 'Общая информация о вине',
                changeVisible: () {
                  BlocProvider.of<GeneralInfoEditCubit>(context)
                      .changeVisible();
                },
                initialVisible: state.isOpen,
              ),

              // Visible поля для ввода общей информации о вине.
              Visibility(
                visible: state.isOpen,
                child: Column(
                  children: [
                    // название вина
                    TextFieldInput(
                      controller:
                          editWineState.editWineModel.nameTextController,
                      lableText: SResources.wineEditNameTitle,
                      hintText: SResources.wineEditNameHint,
                      fieldAction: TextInputAction.done,
                    ),

                    // Производитель вина
                    const ManufacturerField(),
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
