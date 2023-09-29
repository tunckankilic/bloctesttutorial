import 'dart:convert';
import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/data/models/models.dart';
import 'package:http/http.dart' as http;

// An abstract class defining the contract for a remote data source related to authentication.
abstract class AuthenticationRemoteDataSource {
  // Create a user remotely with the specified attributes.
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  // Get a list of user models from the remote data source.
  Future<List<UserModel>> getUsers();
}

// Constants for API endpoints.
const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

// Concrete implementation of AuthenticationRemoteDataSource.
class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response =
          await _client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'createdAt': createdAt,
                'name': name,
                'avatar': avatar, // Include 'avatar' in the request body
              }),
              headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        // If the response status code is not 200 or 201, throw an APIException.
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      // Re-throw APIException if it's already caught.
      rethrow;
    } catch (e) {
      // Catch any other exceptions and throw an APIException with a custom message.
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response =
          await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
