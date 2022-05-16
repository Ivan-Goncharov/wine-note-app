//класс для сохранения рейтинга
class WineRating {
  double ratingAroma = 0.0;
  double ratingTaste = 0.0;
  double ratingAppearance = 0.0;
  WineRating({
    required this.ratingAroma,
    required this.ratingTaste,
    required this.ratingAppearance,
  });

  //метод для создания среднего значения
  double averageRating() {
    double result = (ratingAroma + ratingTaste + ratingAppearance) / 3;
    return result;
  }
}
