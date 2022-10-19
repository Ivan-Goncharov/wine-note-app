/// Поставищик данных с SharedPreferences
abstract class SharedPrefRepo {
  /// Метод для определения - первый запуск приложения или нет
  Future<bool> isFirstLaunch();

  /// Метод для сохранения записи о первом заходе в приложение
  Future<void> saveFirstLaunch(); 
}
