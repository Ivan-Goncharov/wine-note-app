import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/units/edit_wine/domain/edit_wine_repo.dart';
import 'package:flutter_my_wine_app/units/edit_wine/data/edit_wine_model.dart';

class EditWineRepoImpl implements EditWineRepo {
  @override
  EditWineModel createEditWineModel() {
    return EditWineModel(
      nameTextController: TextEditingController(),
      manufTextController: TextEditingController(),
      countryTextController: TextEditingController(),
      regionTextController: TextEditingController(),
      vendorTextController: TextEditingController(),
      aromaTextController: TextEditingController(),
      grapeVarietyTextController: TextEditingController(),
      tasteTextController: TextEditingController(),
      wineColorsTextController: TextEditingController(),
      imageUrl: '',
      commnetTextController: TextEditingController(),
      price: 0.0,
      alcoPercent: 0.0,
      ratingAroma: 0.0,
      ratingTaste: 0.0,
      ratingAppearance: 0.0,
      year: DateTime.now(),
      creationDate: DateTime.now(),
    );
  }

  @override
  Future<EditWineModel> getModelDB(String id) async {
    return EditWineModel.fromWineItem(
        await DBProvider.instanse.searchWineItem(id));
  }

  @override
  Future<void> createNewNote(EditWineModel editWineModel) {
    if (editWineModel.imageUrl.isEmpty) {
      editWineModel.imageUrl = 'assets/images/not_found_color.png';
    }
    return DBProvider.instanse.update(editWineModel.fromEditWineModel());
  }

  @override
  Future<void> updateNoteWine(EditWineModel editWineModel) {
    if (editWineModel.imageUrl.isEmpty) {
      editWineModel.imageUrl = 'assets/images/not_found_color.png';
    }

    return DBProvider.instanse.create(editWineModel.fromEditWineModel());
  }
}
