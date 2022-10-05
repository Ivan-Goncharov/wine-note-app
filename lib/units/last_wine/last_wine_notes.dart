import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/units/last_wine/bloc/last_wine_bloc.dart';
import 'package:flutter_my_wine_app/units/tabs_screen.dart';
import '../../widgets/system_widget/app_bar.dart';
import '../../widgets/system_widget/custom_showcase.dart';
import '../../widgets/system_widget/wine_note_item.dart';
import '../../widgets/system_widget/null_notes_message.dart';
import '../../widgets/system_widget/switch_theme.dart';

class LastWineNote extends StatelessWidget {
  const LastWineNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LastWineBloc>()..add(LastWineInitialEvent()),
      child: const _LastWineNoteBody(),
    );
  }
}

//Экран для вывода последних 10 записей
class _LastWineNoteBody extends StatelessWidget {
  const _LastWineNoteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Последние заметки',
        listOfAction: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomShowCaseWidget(
              showCaseKey: TabsScreen.keySwitchTheme,
              widgetDescription: 'Смена темы приложения',
              widget: const SwitchThemeMode(),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Padding(
        padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
        child: _LastWineBlocBody(),
      ),
    );
  }
}

class _LastWineBlocBody extends StatelessWidget {
  const _LastWineBlocBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastWineBloc, LastWineState>(
      builder: (context, state) {
        if (state is LastWineLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LastWineEmptyState) {
          return const NullNotesMessage();
        } else if (state is LastWineLoadedState) {
          return ListView.builder(
            itemBuilder: (_, index) => WineNoteItem(state.wineList[index]),
            itemCount: state.wineList.length,
          );
        } else if (state is LastWineErrorState) {
          return const Center(
              child: Text(
            'Произошла ошибка, попробуйте позже',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
