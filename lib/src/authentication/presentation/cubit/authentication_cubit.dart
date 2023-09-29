import 'package:bloc/bloc.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

// A class representing the authentication Cubit.
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  // An asynchronous method for creating a user.
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    // Call the CreateUser use case with event parameters.
    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    // Handle the result of the use case and emit the corresponding state.
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  // An asynchronous method for getting users.
  Future<void> getUsers() async {
    emit(const GettingUsers());

    // Call the GetUsers use case.
    final result = await _getUsers();

    // Handle the result of the use case and emit the corresponding state.
    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
