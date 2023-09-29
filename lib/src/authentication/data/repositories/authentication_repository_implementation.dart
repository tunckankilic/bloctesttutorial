import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/data/datasources/datasources.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:dartz/dartz.dart';

// A concrete implementation of the AuthenticationRepository interface.
class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      // Call the remote data source to create a user.
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // If successful, return Right indicating success with no specific result.
      return const Right(null);
    } on APIException catch (e) {
      // If the remote data source throws an APIException, return Left with an APIFailure.
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      // Call the remote data source to get a list of users.
      final result = await _remoteDataSource.getUsers();

      // If successful, return Right with the list of users.
      return Right(result);
    } on APIException catch (e) {
      // If the remote data source throws an APIException, return Left with an APIFailure.
      return Left(APIFailure.fromException(e));
    }
  }
}
