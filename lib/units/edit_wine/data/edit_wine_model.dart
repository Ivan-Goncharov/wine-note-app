import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

class EditWineModel {
  TextEditingController nameTextController;
  TextEditingController manufTextController;
  TextEditingController countryTextController;
  TextEditingController regionTextController;
  TextEditingController vendorTextController;
  TextEditingController aromaTextController;
  TextEditingController grapeVarietyTextController;
  TextEditingController tasteTextController;
  TextEditingController wineColorsTextController;
  TextEditingController commnetTextController;
  String imageUrl;
  double price;
  double alcoPercent;
  double ratingAroma;
  double ratingTaste;
  double ratingAppearance;
  DateTime year;
  DateTime creationDate;
  String? id;

  EditWineModel({
    required this.nameTextController,
    required this.manufTextController,
    required this.countryTextController,
    required this.regionTextController,
    required this.vendorTextController,
    required this.aromaTextController,
    required this.grapeVarietyTextController,
    required this.tasteTextController,
    required this.wineColorsTextController,
    required this.imageUrl,
    required this.commnetTextController,
    required this.price,
    required this.alcoPercent,
    required this.ratingAroma,
    required this.ratingTaste,
    required this.ratingAppearance,
    required this.year,
    required this.creationDate,
    this.id,
  });

  factory EditWineModel.fromWineItem(WineItem wineNote) {
    return EditWineModel(
      nameTextController: TextEditingController(text: wineNote.name),
      manufTextController: TextEditingController(text: wineNote.manufacturer),
      countryTextController: TextEditingController(text: wineNote.country),
      regionTextController: TextEditingController(text: wineNote.region),
      vendorTextController: TextEditingController(text: wineNote.vendor),
      aromaTextController: TextEditingController(text: wineNote.aroma),
      grapeVarietyTextController:
          TextEditingController(text: wineNote.grapeVariety),
      tasteTextController: TextEditingController(text: wineNote.taste),
      wineColorsTextController:
          TextEditingController(text: wineNote.wineColors),
      commnetTextController: TextEditingController(text: wineNote.comment),
      imageUrl: wineNote.imageUrl,
      price: wineNote.price,
      alcoPercent: wineNote.alcoPercent,
      ratingAroma: wineNote.ratingAroma,
      ratingTaste: wineNote.ratingTaste,
      ratingAppearance: wineNote.ratingAppearance,
      year: wineNote.year!,
      creationDate: wineNote.creationDate!,
      id: wineNote.id,
    );
  }

  WineItem fromEditWineModel() {
    return WineItem(
      name: nameTextController.text.trim(),
      manufacturer: manufTextController.text.trim(),
      country: countryTextController.text.trim(),
      region: regionTextController.text.trim(),
      price: price,
      vendor: vendorTextController.text.trim(),
      alcoPercent: alcoPercent,
      ratingAroma: ratingAroma,
      ratingTaste: ratingTaste,
      ratingAppearance: ratingAppearance,
      year: year,
      creationDate: creationDate,
      aroma: aromaTextController.text.trim(),
      grapeVariety: grapeVarietyTextController.text.trim(),
      taste: tasteTextController.text.trim(),
      wineColors: wineColorsTextController.text.trim(),
      comment: commnetTextController.text.trim(),
      imageUrl: imageUrl,
    );
  }
}
