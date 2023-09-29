import 'package:equatable/equatable.dart';

// A class representing user data, extending the Equatable class.
class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  // A constructor to create an empty User with default values.
  const User.empty()
      : this(
          id: '1',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  // Properties representing user attributes.
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  // Override the 'props' method from Equatable for object comparison.
  @override
  List<Object?> get props => [id, name, avatar];
}
