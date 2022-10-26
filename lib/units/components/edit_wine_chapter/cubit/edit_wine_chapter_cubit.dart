import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_wine_chapter_state.dart';

class EditWineChapterCubit extends Cubit<EditWineChapterState> {
  EditWineChapterCubit() : super(EditWineChapterInitial());
  late bool _isOpen = false;

  void initial(bool initValue) {
    _isOpen = initValue;
    emit(EditWineChapterChangeState(_isOpen));
  }

  void changeStatus() {
    _isOpen = !_isOpen;
    emit(EditWineChapterChangeState(_isOpen));
  }
}
