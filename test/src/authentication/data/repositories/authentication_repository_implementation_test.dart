import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/data/datasources/datasources.dart';
import 'package:bloctesttutorial/src/authentication/data/models/models.dart';
import 'package:bloctesttutorial/src/authentication/data/repositories/repositories.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  // Declare variables for the remote data source and repository implementation
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  // Set up the test environment before running tests
  setUp(() {
    // Create a mock instance of AuthenticationRemoteDataSource
    remoteDataSource = MockAuthRemoteDataSrc();
    // Initialize the repository implementation with the mock data source
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  // Define a sample APIException for testing
  const tException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  group('createUser', () {
    // Define constants for testing
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    // Test: createUser should call RemoteDataSource.createUser successfully
    test(
      'should call the [RemoteDataSource.createUser] and complete '
      'successfully when the call to the remote source is successful',
      () async {
        // Arrange: Set up a mock behavior for remote data source
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenAnswer((_) async => Future.value());

        // Act: Call the createUser method in the repository
        final result = await repoImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        // Assert: Verify the result and method calls
        expect(result, equals(const Right(null)));
        verify(() => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    // Test: createUser should return APIFailure on unsuccessful remote call
    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        // Arrange: Set up a mock behavior for remote data source
        when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'))).thenThrow(tException);

        // Act: Call the createUser method in the repository
        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // Assert: Verify the result and method calls
        expect(
          result,
          equals(
            Left(
              APIFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(() => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUsers', () {
    // Test: getUsers should call RemoteDataSource.getUsers successfully
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>]'
      ' when the call to remote source is successful',
      () async {
        // Define a sample list of users
        const expectedUsers = [UserModel.empty()];
        // Arrange: Set up a mock behavior for remote data source
        when(() => remoteDataSource.getUsers()).thenAnswer(
          (_) async => expectedUsers,
        );

        // Act: Call the getUsers method in the repository
        final result = await repoImpl.getUsers();

        // Assert: Verify the result and method calls
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    // Test: getUsers should return APIFailure on unsuccessful remote call
    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        // Arrange: Set up a mock behavior for remote data source
        when(() => remoteDataSource.getUsers()).thenThrow(tException);

        // Act: Call the getUsers method in the repository
        final result = await repoImpl.getUsers();

        // Assert: Verify the result and method calls
        expect(result, equals(Left(APIFailure.fromException(tException))));
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
