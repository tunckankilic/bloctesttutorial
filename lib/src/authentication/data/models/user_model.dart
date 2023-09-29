import 'dart:convert';
import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';

// A class representing a user model, extending the 'User' class.
class UserModel extends User {
  const UserModel({
    required super.avatar,
    required super.id,
    required super.createdAt,
    required super.name,
  });

  // A constructor to create an empty UserModel with default values.
  const UserModel.empty()
      : this(
          id: '1',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  // A factory constructor to create a UserModel from JSON data.
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  // A constructor to create a UserModel from a map of data.
  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          id: map['id'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
        );

  // A method to create a copy of the UserModel with optional new values.
  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }

  // A method to convert the UserModel to a map for serialization.
  DataMap toMap() => {
        'id': id,
        'avatar': avatar,
        'createdAt': createdAt,
        'name': name,
      };

  // A method to convert the UserModel to JSON format.
  String toJson() => jsonEncode(toMap());
}
