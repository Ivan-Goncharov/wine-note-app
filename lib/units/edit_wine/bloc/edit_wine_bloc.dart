import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_screen_state.dart';
import 'package:flutter_my_wine_app/units/edit_wine/domain/edit_wine_repo.dart';
import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_model.dart';
import 'package:meta/meta.dart';

part 'edit_wine_event.dart';
part 'edit_wine_state.dart';

class EditWineBloc extends Bloc<EditWineEvent, EditWineState> {
  late EditWineModel editWineModel;
  final EditWineRepo editWineRepo;
  late EditWineScreenState screenState;
  String? id;
  EditWineBloc(this.editWineRepo) : super(EditWineInitial()) {
    on<EditWineInitialEvent>(_onInitial);
    on<EditWineSaveEvent>(_onSaveNote);
  }

  Future<void> _onInitial(
      EditWineInitialEvent event, Emitter<EditWineState> emit) async {
    emit(EditWineLoadingState());
    if (event.id != null) {
      editWineModel = await editWineRepo.getModelDB(event.id!);
      screenState = EditWineScreenState(isChange: true);
      id = event.id;
    } else {
      editWineModel = editWineRepo.createEditWineModel();
      screenState = EditWineScreenState(isChange: false);
    }
    emit(EditWineLoadedState(
      editWineModel,
      screenState,
    ));
  }

  

  Future<void> _onSaveNote(
    EditWineEvent event,
    Emitter<EditWineState> emit,
  ) async {
    if (id != null) {
      await editWineRepo.updateNoteWine(editWineModel);
    } else {
      await editWineRepo.createNewNote(editWineModel);
    }
  }
}
