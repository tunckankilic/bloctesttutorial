import 'dart:convert';

import 'package:bloctesttutorial/core/core.dart';
import 'package:bloctesttutorial/src/authentication/data/datasources/datasources.dart';
import 'package:bloctesttutorial/src/authentication/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// Import the necessary libraries
import 'dart:io';

// Define a utility function to read fixture files during testing
String fixture(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();

// The `fixture` function takes a `fileName` as input and returns the content of a fixture file.

// MockClient class for simulating HTTP requests
class MockClient extends Mock implements http.Client {}

// Define the main function for running tests
void main() {
  // Declare variables for the mock HTTP client and remote data source
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  // Set up the test environment before running tests
  setUp(() {
    // Initialize the mock HTTP client
    client = MockClient();

    // Create an instance of the AuthenticationRemoteDataSource with the mock client
    remoteDataSource = AuthRemoteDataSrcImpl(client);

    // Register a fallback value for URIs to avoid errors in mock verifications
    registerFallbackValue(Uri());
  });

  // Group of tests for createUser method
  group('createUser', () {
    // Test case: createUser completes successfully when status code is 200 or 201
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        // Set up a mock behavior for HTTP POST request
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        // Get a reference to the remoteDataSource.createUser method
        final methodCall = remoteDataSource.createUser;

        // Expect that the method call completes successfully
        expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes,
        );

        // Verify that the expected HTTP POST request was made exactly once
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        // Verify that there are no more interactions with the client
        verifyNoMoreInteractions(client);
      },
    );

    // Test case: createUser throws APIException when status code is not 200 or 201
    test(
      'should throw [APIException] when the status code is not 200 or 201',
      () async {
        // Set up a mock behavior for HTTP POST request with a bad status code
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );

        // Get a reference to the remoteDataSource.createUser method
        final methodCall = remoteDataSource.createUser;

        // Expect that the method call throws an APIException
        expect(
          () async => methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(
            const APIException(
              message: 'Invalid email address',
              statusCode: 400,
            ),
          ),
        );

        // Verify that the expected HTTP POST request was made exactly once
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        // Verify that there are no more interactions with the client
        verifyNoMoreInteractions(client);
      },
    );
  });

  // Group of tests for getUsers method
  group('getUsers', () {
    // Define a sample list of users
    const tUsers = [UserModel.empty()];

    // Test case: getUsers returns [List<User>] when status code is 200
    test(
      'should return [List<User>] when the status code is 200',
      () async {
        // Set up a mock behavior for HTTP GET request with status code 200
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        // Call the remoteDataSource.getUsers method and store the result
        final result = await remoteDataSource.getUsers();

        // Expect that the result matches the sample list of users
        expect(result, equals(tUsers));

        // Verify that the expected HTTP GET request was made exactly once
        verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
            .called(1);

        // Verify that there are no more interactions with the client
        verifyNoMoreInteractions(client);
      },
    );

    // Test case: getUsers throws APIException when status code is not 200
    test('should throw [APIException] when the status code is not 200',
        () async {
      // Define a sample error
    });
  });
}
