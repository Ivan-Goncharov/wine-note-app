import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_wine_chapter_state.dart';

class EditWineChapterCubit extends Cubit<EditWineChapterState> {
  EditWineChapterCubit() : super(EditWineChapterInitial());
  var _isOpen = false;

  void initial() {
    emit(EditWineChapterChangeState(_isOpen));
  }

  void changeStatus() {
    _isOpen = !_isOpen;
    emit(EditWineChapterChangeState(_isOpen));
  }
}
