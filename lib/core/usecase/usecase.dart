import 'package:bloctesttutorial/core/core.dart';

// An abstract class representing a use case with parameters.
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  // The `call` method takes parameters and returns a ResultFuture.
  // It represents the core logic of the use case.
  ResultFuture<Type> call(Params params);
}

// An abstract class representing a use case without parameters.
abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  // The `call` method does not take parameters and returns a ResultFuture.
  // It represents the core logic of the use case.
  ResultFuture<Type> call();
}
