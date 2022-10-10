part of 'edit_wine_bloc.dart';

@immutable
abstract class EditWineState {}

class EditWineInitial extends EditWineState {}

class EditWineLoadingState extends EditWineState {}

class EditWineLoadedState extends EditWineState {
  final EditWineModel editWineModel;
  final EditWineScreenState screenState;
  EditWineLoadedState(
    this.editWineModel,
    this.screenState,
  );
}

class EditWineErrorLoadedState extends EditWineState {}
