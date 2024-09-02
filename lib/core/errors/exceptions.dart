import 'package:equatable/equatable.dart';

class ServerExceptions extends Equatable implements Exception {
  final String? message;

  const ServerExceptions([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerExceptions {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerExceptions {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerExceptions {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerExceptions {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerExceptions {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerExceptions {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerExceptions {
  const NoInternetConnectionException([message])
      : super("No Internet Connection $message");
}

class CacheExcptions implements Exception {}
