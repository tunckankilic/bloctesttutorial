import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'authentication_repository.mock.dart';

void main() {
  // Declare variables for the use case and repository
  late CreateUser usecase;
  late AuthenticationRepository repository;

  // Set up the test environment before running the test
  setUp(() {
    // Create a mock instance of the AuthenticationRepository
    repository = MockAuthRepo();
    // Initialize the use case with the mock repository
    usecase = CreateUser(repository);
  });

  // Define constant parameters for testing
  const params = CreateUserParams.empty();

  test(
    'should call the [AuthRepo.createUser]',
    () async {
      // Arrange
      // STUB: Set up a mock behavior for repository.createUser
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act: Call the use case with the provided parameters
      final result = await usecase(params);

      // Assert: Verify the result and method calls
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
