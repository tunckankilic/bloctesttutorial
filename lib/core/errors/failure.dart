import 'package:bloctesttutorial/core/errors/errors.dart';
import 'package:equatable/equatable.dart';

// An abstract base class for representing failures in your application.
abstract class Failure extends Equatable {
  // Constructor for creating a Failure instance.
  // Requires a message and a status code.
  const Failure({required this.message, required this.statusCode});

  // The error message associated with this failure.
  final String message;

  // The HTTP status code associated with this failure.
  final int statusCode;

  // A computed property that combines the status code and message to form a descriptive error message.
  String get errorMessage => '$statusCode Error: $message';

  // Override the 'props' method from Equatable for object comparison.
  @override
  List<Object> get props => [message, statusCode];
}

// A specific type of failure that represents API-related errors.
class APIFailure extends Failure {
  // Constructor for creating an APIFailure instance by providing the message and status code.
  const APIFailure({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);

  // Constructor that creates an APIFailure instance from an APIException.
  APIFailure.fromException(APIException exception)
      : super(message: exception.message, statusCode: exception.statusCode);
}
