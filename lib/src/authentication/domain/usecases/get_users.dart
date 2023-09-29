import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';

// A class representing a use case for getting a list of users.
class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
