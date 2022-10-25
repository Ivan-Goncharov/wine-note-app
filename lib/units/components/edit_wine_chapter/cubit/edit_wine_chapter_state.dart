part of 'edit_wine_chapter_cubit.dart';

@immutable
abstract class EditWineChapterState {}

class EditWineChapterInitial extends EditWineChapterState {}

// ignore: must_be_immutable
class EditWineChapterChangeState extends EditWineChapterState {
  bool isOpen;
  EditWineChapterChangeState(this.isOpen);
}
