class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class CacheException extends AppException {
  CacheException(super.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}
