class EditWineScreenState {
  bool isVisGeneralInfo;
  bool isVisMainFeatures;
  bool isVisTasting;
  bool isChange;

  EditWineScreenState({
    required this.isChange,
    this.isVisGeneralInfo = false,
    this.isVisMainFeatures = false,
    this.isVisTasting = false,
  });
}
