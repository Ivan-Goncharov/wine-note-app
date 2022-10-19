part of 'image_pick_cubit.dart';

@immutable
class ImagePickState {
}

class ImagePickInitial extends ImagePickState {
  ImagePickInitial();
}

class ImagePickEmptyState extends ImagePickState {}

class ImagePickAssetState extends ImagePickState {
  final String imageUrl;
  ImagePickAssetState(this.imageUrl);
}

class ImagePickUserPhotoState extends ImagePickState {
  final File image;
  ImagePickUserPhotoState(this.image);
}

class ImagePickSuccefulState extends ImagePickState {
  final String imagePath;
  final File image;

  ImagePickSuccefulState(this.imagePath, this.image);
}
