import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/units/last_wine/domain/last_wine_repo.dart';
import 'package:meta/meta.dart';

part 'last_wine_event.dart';
part 'last_wine_state.dart';

class LastWineBloc extends Bloc<LastWineEvent, LastWineState> {
  final LastWineRepo lastWineRepo;
  LastWineBloc(this.lastWineRepo) : super(LastWineInitial()) {
    on<LastWineInitialEvent>((event, emit) async {
      var listOfWine = <WineItem>[];
      emit(LastWineLoadingState());
      await Future.delayed(const Duration(seconds: 10));
      try {
        listOfWine = await lastWineRepo.fetchListOfLastWine();
        if (listOfWine.isEmpty) {
          emit(LastWineEmptyState());
        } else {
          emit(LastWineLoadedState(listOfWine));
        }
      } catch (_) {
        emit(LastWineErrorState());
      }
    });
  }
}
