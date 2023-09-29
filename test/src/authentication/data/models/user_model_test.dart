import 'dart:convert';

import 'package:bloctesttutorial/core/utils/utils.dart';
import 'package:bloctesttutorial/src/authentication/data/models/models.dart';
import 'package:bloctesttutorial/src/authentication/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // Create a sample UserModel instance for testing
  const tModel = UserModel.empty();

  // Test: UserModel should be a subclass of the User entity
  test('should be a subclass of [User] entity', () {
    // Assert
    expect(tModel, isA<User>());
  });

  // Load a sample JSON string from a fixture file
  final tJson = fixture('user.json');
  // Decode the JSON string into a DataMap
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    // Test: fromMap should return a UserModel with the right data
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    // Test: fromJson should return a UserModel with the right data
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(tJson);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    // Test: toMap should return a Map with the right data
    test('should return a [Map] with the right data', () {
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    // Test: toJson should return a JSON string with the right data
    test('should return a [JSON] string with the right data', () {
      // Act
      final result = tModel.toJson();
      // Define the expected JSON string
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });
      // Assert
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    // Test: copyWith should return a UserModel with different data
    test('should return a [UserModel] with different data', () {
      // Act
      final result = tModel.copyWith(name: 'Paul');
      // Assert
      expect(result.name, equals('Paul'));
    });
  });
}
