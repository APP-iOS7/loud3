class PasswordMismatchException implements Exception {
  String code;
  String message;

  PasswordMismatchException({required this.code, required this.message});

  @override
  String toString() {
    return message;
  }
}
