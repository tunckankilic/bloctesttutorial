import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';

// An abstract class defining the contract for an authentication repository.
abstract class AuthenticationRepository {
  const AuthenticationRepository();

  // A method for creating a user with the provided attributes.
  // This method returns a ResultVoid, indicating success or failure with no specific result.
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  // A method for getting a list of user models.
  // This method returns a ResultFuture, which represents an asynchronous operation.
  // The operation can either succeed with a list of User objects or fail with a Failure.
  ResultFuture<List<User>> getUsers();
}
