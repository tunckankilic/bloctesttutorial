import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  // Constructor for creating an APIException instance.
  // Requires a message and a status code.
  const APIException({required this.message, required this.statusCode});

  // The error message associated with this exception.
  final String message;

  // The HTTP status code associated with this exception.
  final int statusCode;

  // Override the 'props' method from Equatable for object comparison.
  @override
  List<Object?> get props => [message, statusCode];
}
