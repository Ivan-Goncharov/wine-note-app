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

  EditWineScreenState copyWith({
    bool? newisVisGeneralInfo,
    bool? newisVisMainFeatures,
    bool? newisVisTasting,
  }) {
    return EditWineScreenState(
      isChange: isChange,
      isVisGeneralInfo: newisVisGeneralInfo ?? isVisGeneralInfo,
      isVisMainFeatures: newisVisMainFeatures ?? isVisMainFeatures,
      isVisTasting: newisVisTasting ?? isVisTasting,
    );
  }
}
