part of 'last_wine_bloc.dart';

@immutable
abstract class LastWineState {}

class LastWineInitial extends LastWineState {}

class LastWineLoadingState extends LastWineState {}

class LastWineEmptyState extends LastWineState {}

class LastWineLoadedState extends LastWineState {
  final List<WineItem> wineList;
  LastWineLoadedState(this.wineList);
}

class LastWineErrorState extends LastWineState {}
