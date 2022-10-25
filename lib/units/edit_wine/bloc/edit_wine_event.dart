part of 'edit_wine_bloc.dart';

@immutable
abstract class EditWineEvent {}

class EditWineInitialEvent implements EditWineEvent {
  final String? id;
  EditWineInitialEvent(this.id);
}

class EditWineSaveEvent implements EditWineEvent {}

class EditWineSaveImage implements EditWineEvent {
  final File image;
  EditWineSaveImage(this.image);
}

class ChangeVisibleGeneralInfoEvent implements EditWineEvent {
}
