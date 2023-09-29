part of 'authentication_bloc.dart';

// An abstract class representing a generic authentication event.
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// A class representing an event for creating a user.
class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [createdAt, name, avatar];
}

// A class representing an event for getting a list of users.
class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
