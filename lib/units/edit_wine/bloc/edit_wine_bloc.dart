import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_screen_state.dart';
import 'package:flutter_my_wine_app/units/edit_wine/domain/edit_wine_repo.dart';
import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_model.dart';

part 'edit_wine_event.dart';
part 'edit_wine_state.dart';

class EditWineBloc extends Bloc<EditWineEvent, EditWineState> {
  late EditWineModel _editWineModel;
  final EditWineRepo _editWineRepo;
  late EditWineScreenState _screenState;
  String? id;
  EditWineBloc(this._editWineRepo) : super(EditWineInitial()) {
    on<EditWineInitialEvent>(_onInitial);
    on<EditWineSaveEvent>(_onSaveNote);
    on<EditWineSaveImage>(_onSaveImage);
    on<ChangeVisibleGeneralInfoEvent>(_changeVisibleGeneralInfo);
  }

  Future<void> _onInitial(
      EditWineInitialEvent event, Emitter<EditWineState> emit) async {
    emit(EditWineLoadingState());
    try {
      if (event.id != null) {
        _editWineModel = await _editWineRepo.getModelDB(event.id!);
        _screenState = EditWineScreenState(isChange: true);
        id = event.id;
      } else {
        _editWineModel = _editWineRepo.createEditWineModel();
        _screenState = EditWineScreenState(isChange: false);
      }
      emit(EditWineLoadedState(
        _editWineModel,
        _screenState,
      ));
    } catch (er) {
      debugPrint(er.toString());
      emit(EditWineLoadingState());
    }
  }

  void _onSaveImage(EditWineSaveImage event, _) {
    _editWineModel.imageUrl = event.image.path;
  }

  Future<void> _onSaveNote(
    EditWineEvent event,
    Emitter<EditWineState> emit,
  ) async {
    if (id != null) {
      await _editWineRepo.updateNoteWine(_editWineModel);
    } else {
      await _editWineRepo.createNewNote(_editWineModel);
    }
  }

  void _changeVisibleGeneralInfo(
    ChangeVisibleGeneralInfoEvent event,
    Emitter<EditWineState> emit,
  ) {
    _screenState = _screenState.copyWith(
        newisVisGeneralInfo: !_screenState.isVisGeneralInfo);
    emit(EditWineLoadedState(
      _editWineModel,
      _screenState,
    ));
  }
}
