import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_pick_state.dart';

class ImagePickCubit extends Cubit<ImagePickState> {
  ImagePickCubit() : super(ImagePickInitial());

  void initial(String imageUrl) {
    
  } 
}
