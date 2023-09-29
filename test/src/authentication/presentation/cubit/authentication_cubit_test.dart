import 'package:bloc_test/bloc_test.dart';
import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:bloctesttutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  // Declare variables for GetUsers, CreateUser, and AuthenticationCubit
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  // Create a constant CreateUserParams and APIFailure for testing
  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 400);

  // Set up the test environment before running the tests
  setUp(() {
    // Create mock instances of GetUsers and CreateUser
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    // Initialize the AuthenticationCubit with the mock GetUsers and CreateUser
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    // Register a fallback value for CreateUserParams
    registerFallbackValue(tCreateUserParams);
  });

  // Clean up resources after each test
  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    // Assert that the initial state of the cubit is AuthenticationInitial
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    // Test the createUser functionality
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, UserCreated] when successful',
      build: () {
        // STUB: Set up a mock behavior for createUser
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => const [
        CreatingUser(),
        UserCreated(),
      ],
      verify: (_) {
        // Verify that the createUser method is called once
        verify(() => createUser(tCreateUserParams)).called(1);
        // Verify that there are no more interactions with createUser
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when unsuccessful',
      build: () {
        // STUB: Set up a mock behavior for createUser to return a failure
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => [
        const CreatingUser(),
        AuthenticationError(tAPIFailure.errorMessage),
      ],
      verify: (_) {
        // Verify that the createUser method is called once
        verify(() => createUser(tCreateUserParams)).called(1);
        // Verify that there are no more interactions with createUser
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUsers', () {
    // Test the getUsers functionality
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, UsersLoaded] when successful',
      build: () {
        // STUB: Set up a mock behavior for getUsers to return an empty list
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (_) {
        // Verify that the getUsers method is called once
        verify(() => getUsers()).called(1);
        // Verify that there are no more interactions with getUsers
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUsers, AuthenticationError] when unsuccessful',
      build: () {
        // STUB: Set up a mock behavior for getUsers to return a failure
        when(() => getUsers()).thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthenticationError(tAPIFailure.errorMessage),
      ],
      verify: (_) {
        // Verify that the getUsers method is called once
        verify(() => getUsers()).called(1);
        // Verify that there are no more interactions with getUsers
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
