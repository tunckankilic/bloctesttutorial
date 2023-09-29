part of 'authentication_bloc.dart';

// An abstract class representing a generic authentication state.
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// A class representing the initial state of authentication.
class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// A class representing the state when a user is being created.
class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

// A class representing the state when users are being retrieved.
class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

// A class representing the state when a user has been successfully created.
class UserCreated extends AuthenticationState {
  const UserCreated();
}

// A class representing the state when a list of users has been loaded.
class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

// A class representing an error state with an error message.
class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
