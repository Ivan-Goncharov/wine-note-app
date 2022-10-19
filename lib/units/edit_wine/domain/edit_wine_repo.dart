import 'dart:io';

import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_model.dart';

abstract class EditWineRepo {
  Future<EditWineModel> getModelDB(String id);

  EditWineModel createEditWineModel();

  Future<void> createNewNote(EditWineModel editWineModel);

  Future<void> updateNoteWine(EditWineModel editWineModel);

  Future<String> saveImageFile(File image);
}
