/// класс для выбрасывания ошибок, связанных с подключением к серверу
class HttpExeption implements Exception {
  final String message;
  HttpExeption(this.message);

  @override
  String toString() {
    return message;
  }
}
